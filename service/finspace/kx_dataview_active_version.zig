const KxDataviewSegmentConfiguration = @import("kx_dataview_segment_configuration.zig").KxDataviewSegmentConfiguration;

/// The active version of the dataview that is currently in use by this cluster.
pub const KxDataviewActiveVersion = struct {
    /// The list of clusters that are currently using this dataview.
    attached_clusters: ?[]const []const u8,

    /// A unique identifier for the changeset.
    changeset_id: ?[]const u8,

    /// The timestamp at which the dataview version was active. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64,

    /// The configuration that contains the database path of the data that you want
    /// to place on each selected volume. Each segment must have a unique database
    /// path for each volume. If you do not explicitly specify any database path for
    /// a volume, they are accessible from the cluster through the default S3/object
    /// store segment.
    segment_configurations: ?[]const KxDataviewSegmentConfiguration,

    /// A unique identifier of the active version.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .attached_clusters = "attachedClusters",
        .changeset_id = "changesetId",
        .created_timestamp = "createdTimestamp",
        .segment_configurations = "segmentConfigurations",
        .version_id = "versionId",
    };
};
