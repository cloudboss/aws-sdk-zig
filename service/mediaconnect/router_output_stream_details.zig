const MediaConnectFlowRouterOutputStreamDetails = @import("media_connect_flow_router_output_stream_details.zig").MediaConnectFlowRouterOutputStreamDetails;
const MediaLiveInputRouterOutputStreamDetails = @import("media_live_input_router_output_stream_details.zig").MediaLiveInputRouterOutputStreamDetails;
const StandardRouterOutputStreamDetails = @import("standard_router_output_stream_details.zig").StandardRouterOutputStreamDetails;

/// Information about the router output's stream, including connection state and
/// destination details. The specific details provided vary based on the router
/// output type.
pub const RouterOutputStreamDetails = union(enum) {
    media_connect_flow: ?MediaConnectFlowRouterOutputStreamDetails,
    media_live_input: ?MediaLiveInputRouterOutputStreamDetails,
    standard: ?StandardRouterOutputStreamDetails,

    pub const json_field_names = .{
        .media_connect_flow = "MediaConnectFlow",
        .media_live_input = "MediaLiveInput",
        .standard = "Standard",
    };
};
