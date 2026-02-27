/// Output data configuration.
pub const EntityRecognizerOutputDataConfig = struct {
    /// The Amazon S3 prefix for the data lake location of the flywheel statistics.
    flywheel_stats_s3_prefix: ?[]const u8,

    pub const json_field_names = .{
        .flywheel_stats_s3_prefix = "FlywheelStatsS3Prefix",
    };
};
