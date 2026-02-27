const MediaConnectFlowRouterOutputConfiguration = @import("media_connect_flow_router_output_configuration.zig").MediaConnectFlowRouterOutputConfiguration;
const MediaLiveInputRouterOutputConfiguration = @import("media_live_input_router_output_configuration.zig").MediaLiveInputRouterOutputConfiguration;
const StandardRouterOutputConfiguration = @import("standard_router_output_configuration.zig").StandardRouterOutputConfiguration;

/// The configuration settings for a router output.
pub const RouterOutputConfiguration = union(enum) {
    media_connect_flow: ?MediaConnectFlowRouterOutputConfiguration,
    media_live_input: ?MediaLiveInputRouterOutputConfiguration,
    standard: ?StandardRouterOutputConfiguration,

    pub const json_field_names = .{
        .media_connect_flow = "MediaConnectFlow",
        .media_live_input = "MediaLiveInput",
        .standard = "Standard",
    };
};
