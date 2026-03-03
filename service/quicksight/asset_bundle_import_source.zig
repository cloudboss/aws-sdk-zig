/// The source of the asset bundle zip file that contains the data that you want
/// to import.
/// The file must be in `QUICKSIGHT_JSON` format.
pub const AssetBundleImportSource = struct {
    /// The bytes of the base64 encoded asset bundle import zip file. This file
    /// can't
    /// exceed 20 MB. If the size of the file that you want to upload is more than
    /// 20 MB, add the
    /// file to your Amazon S3 bucket and use `S3Uri` of the file for this
    /// operation.
    ///
    /// If you are calling the API operations from the Amazon Web Services SDK for
    /// Java,
    /// JavaScript, Python, or PHP, the SDK encodes base64 automatically to allow
    /// the direct
    /// setting of the zip file's bytes. If you are using an SDK for a different
    /// language or
    /// receiving related errors, try to base64 encode your data.
    body: ?[]const u8 = null,

    /// The Amazon S3 URI for an asset bundle import file that exists in an Amazon
    /// S3 bucket that the caller has read access to. The file must be a zip format
    /// file
    /// and can't exceed 1 GB.
    s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .s3_uri = "S3Uri",
    };
};
