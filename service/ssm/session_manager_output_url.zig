/// Reserved for future use.
pub const SessionManagerOutputUrl = struct {
    /// Reserved for future use.
    cloud_watch_output_url: ?[]const u8,

    /// Reserved for future use.
    s3_output_url: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_output_url = "CloudWatchOutputUrl",
        .s3_output_url = "S3OutputUrl",
    };
};
