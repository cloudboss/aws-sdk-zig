const InlineGroundTruth = @import("inline_ground_truth.zig").InlineGroundTruth;

/// Where to pull ground truth from.
pub const GroundTruthSource = union(enum) {
    /// Inline ground truth data provided directly in the request.
    @"inline": ?InlineGroundTruth,

    pub const json_field_names = .{
        .@"inline" = "inline",
    };
};
