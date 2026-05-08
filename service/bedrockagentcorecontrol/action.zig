const ConfigurationBundleAction = @import("configuration_bundle_action.zig").ConfigurationBundleAction;
const RouteToTargetAction = @import("route_to_target_action.zig").RouteToTargetAction;

/// An action to take when a gateway rule's conditions are met.
pub const Action = union(enum) {
    /// An action that applies a configuration bundle override to the request.
    configuration_bundle: ?ConfigurationBundleAction,
    /// An action that routes the request to a specific target.
    route_to_target: ?RouteToTargetAction,

    pub const json_field_names = .{
        .configuration_bundle = "configurationBundle",
        .route_to_target = "routeToTarget",
    };
};
