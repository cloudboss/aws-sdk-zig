const RistRouterInputConfiguration = @import("rist_router_input_configuration.zig").RistRouterInputConfiguration;
const RtpRouterInputConfiguration = @import("rtp_router_input_configuration.zig").RtpRouterInputConfiguration;
const SrtCallerRouterInputConfiguration = @import("srt_caller_router_input_configuration.zig").SrtCallerRouterInputConfiguration;
const SrtListenerRouterInputConfiguration = @import("srt_listener_router_input_configuration.zig").SrtListenerRouterInputConfiguration;

/// Protocol configuration settings for failover router inputs.
pub const FailoverRouterInputProtocolConfiguration = union(enum) {
    rist: ?RistRouterInputConfiguration,
    rtp: ?RtpRouterInputConfiguration,
    srt_caller: ?SrtCallerRouterInputConfiguration,
    srt_listener: ?SrtListenerRouterInputConfiguration,

    pub const json_field_names = .{
        .rist = "Rist",
        .rtp = "Rtp",
        .srt_caller = "SrtCaller",
        .srt_listener = "SrtListener",
    };
};
