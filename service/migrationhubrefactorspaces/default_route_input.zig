const RouteActivationState = @import("route_activation_state.zig").RouteActivationState;

/// The configuration for the default route type.
pub const DefaultRouteInput = struct {
    /// If set to `ACTIVE`, traffic is forwarded to this route’s service after the
    /// route is created.
    activation_state: ?RouteActivationState = null,

    pub const json_field_names = .{
        .activation_state = "ActivationState",
    };
};
