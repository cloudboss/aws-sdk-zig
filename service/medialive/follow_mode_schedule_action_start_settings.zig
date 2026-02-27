const FollowPoint = @import("follow_point.zig").FollowPoint;

/// Settings to specify if an action follows another.
pub const FollowModeScheduleActionStartSettings = struct {
    /// Identifies whether this action starts relative to the start or relative to
    /// the end of the reference action.
    follow_point: FollowPoint,

    /// The action name of another action that this one refers to.
    reference_action_name: []const u8,

    pub const json_field_names = .{
        .follow_point = "FollowPoint",
        .reference_action_name = "ReferenceActionName",
    };
};
