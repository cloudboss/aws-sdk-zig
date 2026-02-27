/// A list of in-progress multipart uploads for a vault.
pub const UploadListElement = struct {
    /// The description of the archive that was specified in the Initiate Multipart
    /// Upload
    /// request.
    archive_description: ?[]const u8,

    /// The UTC time at which the multipart upload was initiated.
    creation_date: ?[]const u8,

    /// The ID of a multipart upload.
    multipart_upload_id: ?[]const u8,

    /// The part size, in bytes, specified in the Initiate Multipart Upload request.
    /// This is
    /// the size of all the parts in the upload except the last part, which may be
    /// smaller than
    /// this size.
    part_size_in_bytes: i64 = 0,

    /// The Amazon Resource Name (ARN) of the vault that contains the archive.
    vault_arn: ?[]const u8,

    pub const json_field_names = .{
        .archive_description = "ArchiveDescription",
        .creation_date = "CreationDate",
        .multipart_upload_id = "MultipartUploadId",
        .part_size_in_bytes = "PartSizeInBytes",
        .vault_arn = "VaultARN",
    };
};
