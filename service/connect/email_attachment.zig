/// Information about the email attachment files.
pub const EmailAttachment = struct {
    /// A case-sensitive name of the attached file being uploaded.
    file_name: []const u8,

    /// The pre-signed URLs for the S3 bucket where the email attachment is stored.
    s3_url: []const u8,

    pub const json_field_names = .{
        .file_name = "FileName",
        .s3_url = "S3Url",
    };
};
