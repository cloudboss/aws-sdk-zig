const RistRouterInputConfiguration = @import("rist_router_input_configuration.zig").RistRouterInputConfiguration;
const RtpRouterInputConfiguration = @import("rtp_router_input_configuration.zig").RtpRouterInputConfiguration;

/// Protocol configuration settings for merge router inputs.
pub const MergeRouterInputProtocolConfiguration = union(enum) {
    rist: ?RistRouterInputConfiguration,
    rtp: ?RtpRouterInputConfiguration,

    pub const json_field_names = .{
        .rist = "Rist",
        .rtp = "Rtp",
    };
};
