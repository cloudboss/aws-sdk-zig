const SampleDocumentKeys = @import("sample_document_keys.zig").SampleDocumentKeys;

/// Describes a structure that contains the Amazon S3 bucket and an array of the
/// corresponding keys used to identify the location for your sample documents.
pub const SampleDocuments = struct {
    /// Contains the Amazon S3 bucket that is used to hold your sample documents.
    bucket_name: []const u8,

    /// Contains an array of the Amazon S3 keys used to identify the location for
    /// your sample documents.
    keys: []const SampleDocumentKeys,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .keys = "keys",
    };
};
