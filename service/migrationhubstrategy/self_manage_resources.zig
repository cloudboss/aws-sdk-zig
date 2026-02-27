const SelfManageTargetDestination = @import("self_manage_target_destination.zig").SelfManageTargetDestination;

/// Self-managed resources.
pub const SelfManageResources = struct {
    /// Self-managed resources target destination.
    target_destination: []const SelfManageTargetDestination,

    pub const json_field_names = .{
        .target_destination = "targetDestination",
    };
};
