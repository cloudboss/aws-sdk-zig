const DestinationInfo = @import("destination_info.zig").DestinationInfo;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const ExportSnapshotRecordSourceInfo = @import("export_snapshot_record_source_info.zig").ExportSnapshotRecordSourceInfo;
const RecordState = @import("record_state.zig").RecordState;

/// Describes an export snapshot record.
pub const ExportSnapshotRecord = struct {
    /// The Amazon Resource Name (ARN) of the export snapshot record.
    arn: ?[]const u8,

    /// The date when the export snapshot record was created.
    created_at: ?i64,

    /// A list of objects describing the destination of the export snapshot record.
    destination_info: ?DestinationInfo,

    /// The AWS Region and Availability Zone where the export snapshot record is
    /// located.
    location: ?ResourceLocation,

    /// The export snapshot record name.
    name: ?[]const u8,

    /// The Lightsail resource type (`ExportSnapshotRecord`).
    resource_type: ?ResourceType,

    /// A list of objects describing the source of the export snapshot record.
    source_info: ?ExportSnapshotRecordSourceInfo,

    /// The state of the export snapshot record.
    state: ?RecordState,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .destination_info = "destinationInfo",
        .location = "location",
        .name = "name",
        .resource_type = "resourceType",
        .source_info = "sourceInfo",
        .state = "state",
    };
};
