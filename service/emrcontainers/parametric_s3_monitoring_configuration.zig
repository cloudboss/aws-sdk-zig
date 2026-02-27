/// Amazon S3 configuration for monitoring log publishing. You can configure
/// your jobs to
/// send log information to Amazon S3. This data type allows job template
/// parameters to be
/// specified within.
pub const ParametricS3MonitoringConfiguration = struct {
    /// Amazon S3 destination URI for log publishing.
    log_uri: ?[]const u8,

    pub const json_field_names = .{
        .log_uri = "logUri",
    };
};
