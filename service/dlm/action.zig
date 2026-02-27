const CrossRegionCopyAction = @import("cross_region_copy_action.zig").CrossRegionCopyAction;

/// **[Event-based policies only]** Specifies an action for an event-based
/// policy.
pub const Action = struct {
    /// The rule for copying shared snapshots across Regions.
    cross_region_copy: []const CrossRegionCopyAction,

    /// A descriptive name for the action.
    name: []const u8,

    pub const json_field_names = .{
        .cross_region_copy = "CrossRegionCopy",
        .name = "Name",
    };
};
