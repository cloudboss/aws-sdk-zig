const SimulationAppStatus = @import("simulation_app_status.zig").SimulationAppStatus;
const SimulationAppTargetStatus = @import("simulation_app_target_status.zig").SimulationAppTargetStatus;

/// A collection of metadata about the app.
pub const SimulationAppMetadata = struct {
    /// The domain of the app. For more information about domains, see [Key
    /// concepts:
    /// Domains](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/what-is_key-concepts.html#what-is_key-concepts_domains)
    /// in the *SimSpace Weaver User Guide*.
    domain: ?[]const u8,

    /// The name of the app.
    name: ?[]const u8,

    /// The name of the simulation of the app.
    simulation: ?[]const u8,

    /// The current status of the app.
    status: ?SimulationAppStatus,

    /// The desired status of the app.
    target_status: ?SimulationAppTargetStatus,

    pub const json_field_names = .{
        .domain = "Domain",
        .name = "Name",
        .simulation = "Simulation",
        .status = "Status",
        .target_status = "TargetStatus",
    };
};
