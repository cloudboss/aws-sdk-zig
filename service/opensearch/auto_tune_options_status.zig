const AutoTuneOptions = @import("auto_tune_options.zig").AutoTuneOptions;
const AutoTuneStatus = @import("auto_tune_status.zig").AutoTuneStatus;

/// The Auto-Tune status for the domain.
pub const AutoTuneOptionsStatus = struct {
    /// Auto-Tune settings for updating a domain.
    options: ?AutoTuneOptions = null,

    /// The current status of Auto-Tune for a domain.
    status: ?AutoTuneStatus = null,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
