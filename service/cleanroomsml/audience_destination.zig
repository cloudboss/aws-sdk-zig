const S3ConfigMap = @import("s3_config_map.zig").S3ConfigMap;

/// Defines the Amazon S3 bucket where the configured audience is stored.
pub const AudienceDestination = struct {
    /// The Amazon S3 bucket and path for the configured audience.
    s_3_destination: S3ConfigMap,

    pub const json_field_names = .{
        .s_3_destination = "s3Destination",
    };
};
