const KxDataviewActiveVersion = @import("kx_dataview_active_version.zig").KxDataviewActiveVersion;
const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxDataviewSegmentConfiguration = @import("kx_dataview_segment_configuration.zig").KxDataviewSegmentConfiguration;
const KxDataviewStatus = @import("kx_dataview_status.zig").KxDataviewStatus;

/// A collection of kdb dataview entries.
pub const KxDataviewListEntry = struct {
    /// The active changeset versions for the given dataview entry.
    active_versions: ?[]const KxDataviewActiveVersion,

    /// The option to specify whether you want to apply all the future additions and
    /// corrections automatically to the dataview when you ingest new changesets.
    /// The default value is false.
    auto_update: bool = false,

    /// The identifier of the availability zones.
    availability_zone_id: ?[]const u8,

    /// The number of availability zones you want to assign per volume. Currently,
    /// FinSpace only supports `SINGLE` for volumes. This places dataview in a
    /// single AZ.
    az_mode: ?KxAzMode,

    /// A unique identifier for the changeset.
    changeset_id: ?[]const u8,

    /// The timestamp at which the dataview list entry was created in FinSpace. The
    /// value is determined as epoch time in milliseconds. For example, the value
    /// for Monday, November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64,

    /// A unique identifier of the database.
    database_name: ?[]const u8,

    /// A unique identifier of the dataview.
    dataview_name: ?[]const u8,

    /// A description for the dataview list entry.
    description: ?[]const u8,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8,

    /// The last time that the dataview list was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64,

    /// Returns True if the dataview is created as writeable and False otherwise.
    read_write: bool = false,

    /// The configuration that contains the database path of the data that you want
    /// to place on each selected volume. Each segment must have a unique database
    /// path for each volume. If you do not explicitly specify any database path for
    /// a volume, they are accessible from the cluster through the default S3/object
    /// store segment.
    segment_configurations: ?[]const KxDataviewSegmentConfiguration,

    /// The status of a given dataview entry.
    status: ?KxDataviewStatus,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .active_versions = "activeVersions",
        .auto_update = "autoUpdate",
        .availability_zone_id = "availabilityZoneId",
        .az_mode = "azMode",
        .changeset_id = "changesetId",
        .created_timestamp = "createdTimestamp",
        .database_name = "databaseName",
        .dataview_name = "dataviewName",
        .description = "description",
        .environment_id = "environmentId",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .read_write = "readWrite",
        .segment_configurations = "segmentConfigurations",
        .status = "status",
        .status_reason = "statusReason",
    };
};
