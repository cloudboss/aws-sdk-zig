const NetworkAutonomousSystem = @import("network_autonomous_system.zig").NetworkAutonomousSystem;
const NetworkConnection = @import("network_connection.zig").NetworkConnection;
const NetworkGeoLocation = @import("network_geo_location.zig").NetworkGeoLocation;

/// Contains information about network endpoints involved in an Amazon GuardDuty
/// Extended Threat Detection attack sequence. GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
///
/// This field can provide information about the network endpoints associated
/// with the resource in the attack sequence finding,
/// or about a specific network endpoint used for the attack.
pub const NetworkEndpoint = struct {
    /// The Autonomous System Number (ASN) of the network endpoint.
    autonomous_system: ?NetworkAutonomousSystem,

    /// Information about the network connection.
    connection: ?NetworkConnection,

    /// The domain information for the network endpoint.
    domain: ?[]const u8,

    /// The identifier of the network endpoint involved in the attack sequence.
    id: ?[]const u8,

    /// The IP address used in the network endpoint.
    ip: ?[]const u8,

    /// Information about the location of the network endpoint.
    location: ?NetworkGeoLocation,

    /// The port number associated with the network endpoint.
    port: ?i32,

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
