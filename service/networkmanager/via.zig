const NetworkFunctionGroup = @import("network_function_group.zig").NetworkFunctionGroup;
const EdgeOverride = @import("edge_override.zig").EdgeOverride;

/// The list of network function groups and edge overrides for the service
/// insertion
/// action. Used for both the `send-to` and `send-via` actions.
pub const Via = struct {
    /// The list of network function groups associated with the service insertion
    /// action.
    network_function_groups: ?[]const NetworkFunctionGroup = null,

    /// Describes any edge overrides. An edge override is a specific edge to be used
    /// for traffic.
    with_edge_overrides: ?[]const EdgeOverride = null,

    pub const json_field_names = .{
        .network_function_groups = "NetworkFunctionGroups",
        .with_edge_overrides = "WithEdgeOverrides",
    };
};
