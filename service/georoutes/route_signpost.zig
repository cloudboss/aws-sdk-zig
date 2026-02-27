const RouteSignpostLabel = @import("route_signpost_label.zig").RouteSignpostLabel;

/// Sign post information of the action, applicable only for TurnByTurn steps.
/// See RouteSignpost for details of sub-attributes.
pub const RouteSignpost = struct {
    /// Labels present on the sign post.
    labels: []const RouteSignpostLabel,

    pub const json_field_names = .{
        .labels = "Labels",
    };
};
