const TargetGroup = @import("target_group.zig").TargetGroup;

/// Describes the target groups to attach to a Spot Fleet. Spot Fleet registers
/// the
/// running Spot Instances with these target groups.
pub const TargetGroupsConfig = struct {
    /// One or more target groups.
    target_groups: ?[]const TargetGroup = null,
};
