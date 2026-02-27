const S3Object = @import("s3_object.zig").S3Object;

/// Blueprint Optimization Output configuration.
pub const BlueprintOptimizationOutputConfiguration = struct {
    /// S3 object.
    s_3_object: S3Object,

    pub const json_field_names = .{
        .s_3_object = "s3Object",
    };
};
