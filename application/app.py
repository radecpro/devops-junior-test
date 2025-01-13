from flask import Flask, request, redirect, url_for, render_template
from google.cloud import storage

app = Flask(__name__)

# Your bucket name (replace with your actual bucket name)
BUCKET_NAME = "bara-website-content"

# No explicit authentication is needed when running on a Compute Engine
# instance with the appropriate service account attached.

storage_client = storage.Client()
bucket = storage_client.bucket(BUCKET_NAME)


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        if "file" not in request.files:
            return "No file part"

        file = request.files["file"]
        if file.filename == "":
            return "No selected file"

        blob = bucket.blob(file.filename)
        blob.upload_from_file(file)
        return redirect(url_for("index"))


    blobs = list(bucket.list_blobs())
    file_list = [{'name':blob.name, 'public_url': blob.public_url } for blob in blobs]
    return render_template("index.html", files=file_list)



@app.route("/delete/<filename>", methods=["GET"])
def delete_file(filename):
    blob = bucket.blob(filename)

    try:
        blob.delete()
    except Exception as e: # Exception handling for files that do not exist.
        print(f"Error deleting file {filename}: {e}")
        pass # or return an error as appropriate


    return redirect(url_for("index"))



if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
