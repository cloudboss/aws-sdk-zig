const PillarDifference = @import("pillar_difference.zig").PillarDifference;

/// The differences between the base and latest versions of the lens.
pub const VersionDifferences = struct {
    /// The differences between the base and latest versions of the lens.
    pillar_differences: ?[]const PillarDifference = null,

    pub const json_field_names = .{
        .pillar_differences = "PillarDifferences",
    };
};
