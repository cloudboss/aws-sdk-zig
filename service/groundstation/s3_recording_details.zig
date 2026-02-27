/// Details about an S3 recording `Config` used in a contact.
pub const S3RecordingDetails = struct {
    /// ARN of the bucket used.
    bucket_arn: ?[]const u8,

    /// Key template used for the S3 Recording Configuration
    key_template: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn = "bucketArn",
        .key_template = "keyTemplate",
    };
};
