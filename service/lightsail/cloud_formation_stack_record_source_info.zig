const CloudFormationStackRecordSourceType = @import("cloud_formation_stack_record_source_type.zig").CloudFormationStackRecordSourceType;

/// Describes the source of a CloudFormation stack record (i.e., the export
/// snapshot
/// record).
pub const CloudFormationStackRecordSourceInfo = struct {
    /// The Amazon Resource Name (ARN) of the export snapshot record.
    arn: ?[]const u8 = null,

    /// The name of the record.
    name: ?[]const u8 = null,

    /// The Lightsail resource type (`ExportSnapshotRecord`).
    resource_type: ?CloudFormationStackRecordSourceType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .resource_type = "resourceType",
    };
};
