const AutomatedSnapshotPauseOptions = @import("automated_snapshot_pause_options.zig").AutomatedSnapshotPauseOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of automated snapshot pause options for the domain.
pub const AutomatedSnapshotPauseOptionsStatus = struct {
    /// Automated snapshot pause options for the domain.
    options: AutomatedSnapshotPauseOptions,

    /// The current status of the automated snapshot pause options for the domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
