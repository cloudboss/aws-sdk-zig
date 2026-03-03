const SnapshotDestinationConfiguration = @import("snapshot_destination_configuration.zig").SnapshotDestinationConfiguration;
const SnapshotFileGroup = @import("snapshot_file_group.zig").SnapshotFileGroup;
const Parameters = @import("parameters.zig").Parameters;

/// Describes the configuration of the dashboard snapshot.
pub const SnapshotConfiguration = struct {
    /// A structure that contains information on the Amazon S3 bucket that the
    /// generated snapshot is stored in.
    destination_configuration: ?SnapshotDestinationConfiguration = null,

    /// A list of `SnapshotJobResultFileGroup` objects that contain information
    /// about the snapshot that is generated. This list can hold a maximum of 6
    /// `FileGroup` configurations.
    file_groups: []const SnapshotFileGroup,

    parameters: ?Parameters = null,

    pub const json_field_names = .{
        .destination_configuration = "DestinationConfiguration",
        .file_groups = "FileGroups",
        .parameters = "Parameters",
    };
};
