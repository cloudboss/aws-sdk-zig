const InputRequestDestinationRoute = @import("input_request_destination_route.zig").InputRequestDestinationRoute;

/// Endpoint settings for a PUSH type input.
pub const InputDestinationRequest = struct {
    /// If the push input has an input location of ON-PREM, ID the ID of the
    /// attached network.
    network: ?[]const u8,

    /// If the push input has an input location of ON-PREM it's a requirement to
    /// specify what the route of the input
    /// is going to be on the customer local network.
    network_routes: ?[]const InputRequestDestinationRoute,

    /// If the push input has an input location of ON-PREM it's optional to specify
    /// what the ip address
    /// of the input is going to be on the customer local network.
    static_ip_address: ?[]const u8,

    /// A unique name for the location the RTMP stream is being pushed
    /// to.
    stream_name: ?[]const u8,

    pub const json_field_names = .{
        .network = "Network",
        .network_routes = "NetworkRoutes",
        .static_ip_address = "StaticIpAddress",
        .stream_name = "StreamName",
    };
};
