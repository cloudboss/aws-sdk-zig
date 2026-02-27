const InstanceCredentials = @import("instance_credentials.zig").InstanceCredentials;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;

/// Information and credentials that you can use to remotely connect to an
/// instance in an
/// EC2 managed fleet. This data type is returned in response to a call to
/// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetInstanceAccess](https://docs.aws.amazon.com/gamelift/latest/apireference/API_GetInstanceAccess).
pub const InstanceAccess = struct {
    /// Security credentials that are required to access the instance.
    credentials: ?InstanceCredentials,

    /// A unique identifier for the fleet containing the instance to be accessed.
    fleet_id: ?[]const u8,

    /// A unique identifier for the instance to be accessed.
    instance_id: ?[]const u8,

    /// IP address assigned to the instance.
    ip_address: ?[]const u8,

    /// Operating system that is running on the instance.
    operating_system: ?OperatingSystem,

    pub const json_field_names = .{
        .credentials = "Credentials",
        .fleet_id = "FleetId",
        .instance_id = "InstanceId",
        .ip_address = "IpAddress",
        .operating_system = "OperatingSystem",
    };
};
