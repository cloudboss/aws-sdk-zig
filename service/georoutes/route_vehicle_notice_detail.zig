const RouteViolatedConstraints = @import("route_violated_constraints.zig").RouteViolatedConstraints;

/// Additional details of the notice.
pub const RouteVehicleNoticeDetail = struct {
    /// The notice title.
    title: ?[]const u8 = null,

    /// Any violated constraints.
    violated_constraints: ?RouteViolatedConstraints = null,

    pub const json_field_names = .{
        .title = "Title",
        .violated_constraints = "ViolatedConstraints",
    };
};
