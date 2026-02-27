const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Container for information about a daily automated snapshot for an OpenSearch
/// Service
/// domain.
pub const SnapshotOptionsStatus = struct {
    /// The daily snapshot options specified for the domain.
    options: SnapshotOptions,

    /// The status of a daily automated snapshot.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
