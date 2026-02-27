const PositionResourceType = @import("position_resource_type.zig").PositionResourceType;
const PositionSolverDetails = @import("position_solver_details.zig").PositionSolverDetails;

/// The wrapper for a position configuration.
pub const PositionConfigurationItem = struct {
    /// The position data destination that describes the AWS IoT rule that processes
    /// the
    /// device's position data for use by AWS IoT Core for LoRaWAN.
    destination: ?[]const u8,

    /// Resource identifier for the position configuration.
    resource_identifier: ?[]const u8,

    /// Resource type of the resource for the position configuration.
    resource_type: ?PositionResourceType,

    /// The details of the positioning solver object used to compute the location.
    solvers: ?PositionSolverDetails,

    pub const json_field_names = .{
        .destination = "Destination",
        .resource_identifier = "ResourceIdentifier",
        .resource_type = "ResourceType",
        .solvers = "Solvers",
    };
};
