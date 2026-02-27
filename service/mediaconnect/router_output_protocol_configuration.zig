const RistRouterOutputConfiguration = @import("rist_router_output_configuration.zig").RistRouterOutputConfiguration;
const RtpRouterOutputConfiguration = @import("rtp_router_output_configuration.zig").RtpRouterOutputConfiguration;
const SrtCallerRouterOutputConfiguration = @import("srt_caller_router_output_configuration.zig").SrtCallerRouterOutputConfiguration;
const SrtListenerRouterOutputConfiguration = @import("srt_listener_router_output_configuration.zig").SrtListenerRouterOutputConfiguration;

/// The protocol configuration settings for a router output.
pub const RouterOutputProtocolConfiguration = union(enum) {
    rist: ?RistRouterOutputConfiguration,
    rtp: ?RtpRouterOutputConfiguration,
    srt_caller: ?SrtCallerRouterOutputConfiguration,
    srt_listener: ?SrtListenerRouterOutputConfiguration,

    pub const json_field_names = .{
        .rist = "Rist",
        .rtp = "Rtp",
        .srt_caller = "SrtCaller",
        .srt_listener = "SrtListener",
    };
};
