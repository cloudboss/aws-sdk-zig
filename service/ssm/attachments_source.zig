const AttachmentsSourceKey = @import("attachments_source_key.zig").AttachmentsSourceKey;

/// Identifying information about a document attachment, including the file name
/// and a key-value
/// pair that identifies the location of an attachment to a document.
pub const AttachmentsSource = struct {
    /// The key of a key-value pair that identifies the location of an attachment to
    /// a
    /// document.
    key: ?AttachmentsSourceKey = null,

    /// The name of the document attachment file.
    name: ?[]const u8 = null,

    /// The value of a key-value pair that identifies the location of an attachment
    /// to a document.
    /// The format for **Value** depends on the type of key you
    /// specify.
    ///
    /// * For the key *SourceUrl*, the value is an S3 bucket location. For
    /// example:
    ///
    /// `"Values": [ "s3://amzn-s3-demo-bucket/my-prefix" ]`
    ///
    /// * For the key *S3FileUrl*, the value is a file in an S3 bucket. For
    /// example:
    ///
    /// `"Values": [ "s3://amzn-s3-demo-bucket/my-prefix/my-file.py" ]`
    ///
    /// * For the key *AttachmentReference*, the value is constructed from the
    /// name of another SSM document in your account, a version number of that
    /// document, and a file
    /// attached to that document version that you want to reuse. For example:
    ///
    /// `"Values": [ "MyOtherDocument/3/my-other-file.py" ]`
    ///
    /// However, if the SSM document is shared with you from another account, the
    /// full SSM
    /// document ARN must be specified instead of the document name only. For
    /// example:
    ///
    /// `"Values": [
    /// "arn:aws:ssm:us-east-2:111122223333:document/OtherAccountDocument/3/their-file.py"
    /// ]`
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .name = "Name",
        .values = "Values",
    };
};
