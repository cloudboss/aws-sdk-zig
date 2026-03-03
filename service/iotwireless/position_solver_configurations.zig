const SemtechGnssConfiguration = @import("semtech_gnss_configuration.zig").SemtechGnssConfiguration;

/// The wrapper for position solver configurations.
pub const PositionSolverConfigurations = struct {
    /// The Semtech GNSS solver configuration object.
    semtech_gnss: ?SemtechGnssConfiguration = null,

    pub const json_field_names = .{
        .semtech_gnss = "SemtechGnss",
    };
};
