const PositionConfigurationFec = @import("position_configuration_fec.zig").PositionConfigurationFec;
const PositionSolverProvider = @import("position_solver_provider.zig").PositionSolverProvider;
const PositionConfigurationStatus = @import("position_configuration_status.zig").PositionConfigurationStatus;
const PositionSolverType = @import("position_solver_type.zig").PositionSolverType;

/// Details of the Semtech GNSS solver object.
pub const SemtechGnssDetail = struct {
    /// Whether forward error correction is enabled.
    fec: ?PositionConfigurationFec,

    /// The vendor of the solver object.
    provider: ?PositionSolverProvider,

    /// The status indicating whether the solver is enabled.
    status: ?PositionConfigurationStatus,

    /// The type of positioning solver used.
    @"type": ?PositionSolverType,

    pub const json_field_names = .{
        .fec = "Fec",
        .provider = "Provider",
        .status = "Status",
        .@"type" = "Type",
    };
};
