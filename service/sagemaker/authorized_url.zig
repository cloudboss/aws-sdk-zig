/// Contains a presigned URL and its associated local file path for downloading
/// hub content artifacts.
pub const AuthorizedUrl = struct {
    /// The recommended local file path where the downloaded file should be stored
    /// to maintain proper directory structure and file organization.
    local_path: ?[]const u8,

    /// The presigned S3 URL that provides temporary, secure access to download the
    /// file. URLs expire within 15 minutes for security purposes.
    url: ?[]const u8,

    pub const json_field_names = .{
        .local_path = "LocalPath",
        .url = "Url",
    };
};
