const InlineGroundTruth = @import("inline_ground_truth.zig").InlineGroundTruth;

/// Where to pull ground truth from
pub const GroundTruthSource = union(enum) {
    /// Provide ground truth inline
    @"inline": ?InlineGroundTruth,

    pub const json_field_names = .{
        .@"inline" = "inline",
    };
};
