/// Specifies the customer input Amazon S3 file location. If it is used inside
/// `copyStepDetails.DestinationFileLocation`, it should be the S3 copy
/// destination.
///
/// You need to provide the bucket and key. The key can represent either a path
/// or a file. This is determined by whether or not you end the key value with
/// the forward slash (/) character. If the final character is "/", then your
/// file is copied to the folder, and its name does not change. If, rather, the
/// final character is alphanumeric, your uploaded file is renamed to the path
/// value. In this case, if a file with that name already exists, it is
/// overwritten.
///
/// For example, if your path is `shared-files/bob/`, your uploaded files are
/// copied to the `shared-files/bob/`, folder. If your path is
/// `shared-files/today`, each uploaded file is copied to the `shared-files`
/// folder and named `today`: each upload overwrites the previous version of the
/// *bob* file.
pub const S3InputFileLocation = struct {
    /// Specifies the S3 bucket for the customer input file.
    bucket: ?[]const u8 = null,

    /// The name assigned to the file when it was created in Amazon S3. You use the
    /// object key to retrieve the object.
    key: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
