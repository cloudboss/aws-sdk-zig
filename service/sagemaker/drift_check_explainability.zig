const FileSource = @import("file_source.zig").FileSource;
const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Represents the drift check explainability baselines that can be used when
/// the model monitor is set using the model package.
pub const DriftCheckExplainability = struct {
    /// The explainability config file for the model.
    config_file: ?FileSource = null,

    /// The drift check explainability constraints.
    constraints: ?MetricsSource = null,

    pub const json_field_names = .{
        .config_file = "ConfigFile",
        .constraints = "Constraints",
    };
};
