/// The structure of the customer code available within the running cluster.
pub const CodeConfiguration = struct {
    /// A unique name for the S3 bucket.
    s_3_bucket: ?[]const u8 = null,

    /// The full S3 path (excluding bucket) to the .zip file. This file contains the
    /// code that is loaded onto the cluster when it's started.
    s_3_key: ?[]const u8 = null,

    /// The version of an S3 object.
    s_3_object_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
        .s_3_key = "s3Key",
        .s_3_object_version = "s3ObjectVersion",
    };
};
