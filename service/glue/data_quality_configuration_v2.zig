const ObservationMode = @import("observation_mode.zig").ObservationMode;
const ObservationConfiguration = @import("observation_configuration.zig").ObservationConfiguration;

/// The run configuration for a data quality result.
pub const DataQualityConfigurationV2 = struct {
    /// The observation mode for the run. Valid values are:
    ///
    /// * `SCHEDULED`
    ///
    /// * `FIXED`
    observation_mode: ?ObservationMode = null,

    /// Whether observations are enabled for the run. Valid values are:
    ///
    /// * `ALL`
    ///
    /// * `NONE`
    observations_enabled: ?ObservationConfiguration = null,

    pub const json_field_names = .{
        .observation_mode = "ObservationMode",
        .observations_enabled = "ObservationsEnabled",
    };
};
