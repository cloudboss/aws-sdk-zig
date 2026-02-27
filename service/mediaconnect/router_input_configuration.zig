const FailoverRouterInputConfiguration = @import("failover_router_input_configuration.zig").FailoverRouterInputConfiguration;
const MediaConnectFlowRouterInputConfiguration = @import("media_connect_flow_router_input_configuration.zig").MediaConnectFlowRouterInputConfiguration;
const MergeRouterInputConfiguration = @import("merge_router_input_configuration.zig").MergeRouterInputConfiguration;
const StandardRouterInputConfiguration = @import("standard_router_input_configuration.zig").StandardRouterInputConfiguration;

/// The configuration settings for a router input.
pub const RouterInputConfiguration = union(enum) {
    failover: ?FailoverRouterInputConfiguration,
    media_connect_flow: ?MediaConnectFlowRouterInputConfiguration,
    merge: ?MergeRouterInputConfiguration,
    standard: ?StandardRouterInputConfiguration,

    pub const json_field_names = .{
        .failover = "Failover",
        .media_connect_flow = "MediaConnectFlow",
        .merge = "Merge",
        .standard = "Standard",
    };
};
