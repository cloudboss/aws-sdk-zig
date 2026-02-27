const RefreshFailureConfiguration = @import("refresh_failure_configuration.zig").RefreshFailureConfiguration;
const RefreshConfiguration = @import("refresh_configuration.zig").RefreshConfiguration;

/// The refresh properties of a dataset.
pub const DataSetRefreshProperties = struct {
    /// The failure configuration for a dataset.
    failure_configuration: ?RefreshFailureConfiguration,

    /// The refresh configuration for a dataset.
    refresh_configuration: ?RefreshConfiguration,

    pub const json_field_names = .{
        .failure_configuration = "FailureConfiguration",
        .refresh_configuration = "RefreshConfiguration",
    };
};
