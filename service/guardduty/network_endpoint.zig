const AutonomousSystem = @import("autonomous_system.zig").AutonomousSystem;
const NetworkConnection = @import("network_connection.zig").NetworkConnection;
const NetworkGeoLocation = @import("network_geo_location.zig").NetworkGeoLocation;

/// Contains information about network endpoints that were observed in the
/// attack sequence.
pub const NetworkEndpoint = struct {
    /// The Autonomous System (AS) of the network endpoint.
    autonomous_system: ?AutonomousSystem = null,

    /// Information about the network connection.
    connection: ?NetworkConnection = null,

    /// The domain information for the network endpoint.
    domain: ?[]const u8 = null,

    /// The ID of the network endpoint.
    id: []const u8,

    /// The IP address associated with the network endpoint.
    ip: ?[]const u8 = null,

    /// Information about the location of the network endpoint.
    location: ?NetworkGeoLocation = null,

    /// The port number associated with the network endpoint.
    port: ?i32 = null,

    pub const json_field_names = .{
        .autonomous_system = "AutonomousSystem",
        .connection = "Connection",
        .domain = "Domain",
        .id = "Id",
        .ip = "Ip",
        .location = "Location",
        .port = "Port",
    };
};
