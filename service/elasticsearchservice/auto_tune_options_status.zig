const AutoTuneOptions = @import("auto_tune_options.zig").AutoTuneOptions;
const AutoTuneStatus = @import("auto_tune_status.zig").AutoTuneStatus;

/// Specifies the status of Auto-Tune options for the specified Elasticsearch
/// domain.
pub const AutoTuneOptionsStatus = struct {
    /// Specifies Auto-Tune options for the specified Elasticsearch domain.
    options: ?AutoTuneOptions,

    /// Specifies Status of the Auto-Tune options for the specified Elasticsearch
    /// domain.
    status: ?AutoTuneStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
