/// S3 access configuration parameters.
pub const S3AccessConfig = struct {
    /// Location of the access logs.
    access_log_location: ?[]const u8,

    pub const json_field_names = .{
        .access_log_location = "accessLogLocation",
    };
};
