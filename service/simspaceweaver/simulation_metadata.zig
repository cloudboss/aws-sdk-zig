const SimulationStatus = @import("simulation_status.zig").SimulationStatus;
const SimulationTargetStatus = @import("simulation_target_status.zig").SimulationTargetStatus;

/// A collection of data about the simulation.
pub const SimulationMetadata = struct {
    /// The Amazon Resource Name (ARN) of the simulation. For more information about
    /// ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    arn: ?[]const u8,

    /// The time when the simulation was created, expressed as the
    /// number of seconds and milliseconds in UTC since the Unix epoch (0:0:0.000,
    /// January 1, 1970).
    creation_time: ?i64,

    /// The name of the simulation.
    name: ?[]const u8,

    /// The current status of the simulation.
    status: ?SimulationStatus,

    /// The desired status of the simulation.
    target_status: ?SimulationTargetStatus,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .name = "Name",
        .status = "Status",
        .target_status = "TargetStatus",
    };
};
