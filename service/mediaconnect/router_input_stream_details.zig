const FailoverRouterInputStreamDetails = @import("failover_router_input_stream_details.zig").FailoverRouterInputStreamDetails;
const MediaConnectFlowRouterInputStreamDetails = @import("media_connect_flow_router_input_stream_details.zig").MediaConnectFlowRouterInputStreamDetails;
const MediaLiveChannelRouterInputStreamDetails = @import("media_live_channel_router_input_stream_details.zig").MediaLiveChannelRouterInputStreamDetails;
const MergeRouterInputStreamDetails = @import("merge_router_input_stream_details.zig").MergeRouterInputStreamDetails;
const StandardRouterInputStreamDetails = @import("standard_router_input_stream_details.zig").StandardRouterInputStreamDetails;

/// Configuration details for the router input stream.
pub const RouterInputStreamDetails = union(enum) {
    failover: ?FailoverRouterInputStreamDetails,
    media_connect_flow: ?MediaConnectFlowRouterInputStreamDetails,
    media_live_channel: ?MediaLiveChannelRouterInputStreamDetails,
    merge: ?MergeRouterInputStreamDetails,
    standard: ?StandardRouterInputStreamDetails,

    pub const json_field_names = .{
        .failover = "Failover",
        .media_connect_flow = "MediaConnectFlow",
        .media_live_channel = "MediaLiveChannel",
        .merge = "Merge",
        .standard = "Standard",
    };
};
