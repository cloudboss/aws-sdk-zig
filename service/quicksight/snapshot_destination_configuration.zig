const SnapshotS3DestinationConfiguration = @import("snapshot_s3_destination_configuration.zig").SnapshotS3DestinationConfiguration;

/// A structure that contains information on the Amazon S3 destinations of the
/// generated snapshot.
pub const SnapshotDestinationConfiguration = struct {
    /// A list of `SnapshotS3DestinationConfiguration` objects that contain Amazon
    /// S3 destination configurations. This structure can hold a maximum of 1
    /// `S3DestinationConfiguration`.
    s3_destinations: ?[]const SnapshotS3DestinationConfiguration = null,

    pub const json_field_names = .{
        .s3_destinations = "S3Destinations",
    };
};
