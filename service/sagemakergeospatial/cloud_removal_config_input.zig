const AlgorithmNameCloudRemoval = @import("algorithm_name_cloud_removal.zig").AlgorithmNameCloudRemoval;

/// Input structure for Cloud Removal Operation type
pub const CloudRemovalConfigInput = struct {
    /// The name of the algorithm used for cloud removal.
    algorithm_name: ?AlgorithmNameCloudRemoval = null,

    /// The interpolation value you provide for cloud removal.
    interpolation_value: ?[]const u8 = null,

    /// TargetBands to be returned in the output of CloudRemoval operation.
    target_bands: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
        .interpolation_value = "InterpolationValue",
        .target_bands = "TargetBands",
    };
};
