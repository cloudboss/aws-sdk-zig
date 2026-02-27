const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of a daily automated snapshot.
pub const SnapshotOptionsStatus = struct {
    /// Specifies the daily snapshot options specified for the Elasticsearch domain.
    options: SnapshotOptions,

    /// Specifies the status of a daily automated snapshot.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
