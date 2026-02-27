const S3ConfigMap = @import("s3_config_map.zig").S3ConfigMap;

/// The Amazon S3 location where the exported model artifacts are stored.
pub const Destination = struct {
    s_3_destination: S3ConfigMap,

    pub const json_field_names = .{
        .s_3_destination = "s3Destination",
    };
};
