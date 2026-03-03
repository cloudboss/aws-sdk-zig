const ConfigurationRecorderFilterName = @import("configuration_recorder_filter_name.zig").ConfigurationRecorderFilterName;

/// Filters configuration recorders by recording scope.
pub const ConfigurationRecorderFilter = struct {
    /// The name of the type of filter. Currently, only `recordingScope` is
    /// supported.
    filter_name: ?ConfigurationRecorderFilterName = null,

    /// The value of the filter. For `recordingScope`, valid values include:
    /// `INTERNAL` and `PAID`.
    ///
    /// `INTERNAL` indicates that the
    /// [ConfigurationItems](https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigurationItem.html) in scope for the configuration recorder are recorded for free.
    ///
    /// `PAID` indicates that the
    /// [ConfigurationItems](https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigurationItem.html) in scope for the configuration recorder impact the costs to your bill.
    filter_value: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filter_name = "filterName",
        .filter_value = "filterValue",
    };
};
