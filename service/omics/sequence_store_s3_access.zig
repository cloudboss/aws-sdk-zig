/// The S3 access metadata of the sequence store.
pub const SequenceStoreS3Access = struct {
    /// Location of the access logs.
    access_log_location: ?[]const u8,

    /// This is ARN of the access point associated with the S3 bucket storing read
    /// sets.
    s_3_access_point_arn: ?[]const u8,

    /// The S3 URI of the sequence store.
    s_3_uri: ?[]const u8,

    pub const json_field_names = .{
        .access_log_location = "accessLogLocation",
        .s_3_access_point_arn = "s3AccessPointArn",
        .s_3_uri = "s3Uri",
    };
};
