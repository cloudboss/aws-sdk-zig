const PositionConfigurationFec = @import("position_configuration_fec.zig").PositionConfigurationFec;
const PositionConfigurationStatus = @import("position_configuration_status.zig").PositionConfigurationStatus;

/// Information about the Semtech GNSS solver configuration.
pub const SemtechGnssConfiguration = struct {
    /// Whether forward error correction is enabled.
    fec: PositionConfigurationFec,

    /// The status indicating whether the solver is enabled.
    status: PositionConfigurationStatus,

    pub const json_field_names = .{
        .fec = "Fec",
        .status = "Status",
    };
};
