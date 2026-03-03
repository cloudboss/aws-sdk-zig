const InputDestinationRoute = @import("input_destination_route.zig").InputDestinationRoute;
const InputDestinationVpc = @import("input_destination_vpc.zig").InputDestinationVpc;

/// The settings for a PUSH type input.
pub const InputDestination = struct {
    /// The system-generated static IP address of endpoint.
    /// It remains fixed for the lifetime of the input.
    ip: ?[]const u8 = null,

    /// The ID of the attached network.
    network: ?[]const u8 = null,

    /// If the push input has an input location of ON-PREM it's a requirement to
    /// specify what the route of the input
    /// is going to be on the customer local network.
    network_routes: ?[]const InputDestinationRoute = null,

    /// The port number for the input.
    port: ?[]const u8 = null,

    /// This represents the endpoint that the customer stream will be
    /// pushed to.
    url: ?[]const u8 = null,

    vpc: ?InputDestinationVpc = null,

    pub const json_field_names = .{
        .ip = "Ip",
        .network = "Network",
        .network_routes = "NetworkRoutes",
        .port = "Port",
        .url = "Url",
        .vpc = "Vpc",
    };
};
