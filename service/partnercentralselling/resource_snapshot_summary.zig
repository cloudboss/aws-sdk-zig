const ResourceType = @import("resource_type.zig").ResourceType;

/// Provides a concise summary of a resource snapshot, including its unique
/// identifier and version information. This structure is used to quickly
/// reference and identify specific versions of resource snapshots.
pub const ResourceSnapshotSummary = struct {
    /// The Amazon Resource Name (ARN) of the snapshot. This globally unique
    /// identifier can be used for cross-service references and in IAM policies.
    arn: ?[]const u8 = null,

    /// The AWS account ID of the entity that owns the resource from which the
    /// snapshot was created.
    created_by: ?[]const u8 = null,

    /// The identifier of the specific resource snapshotted. The format might vary
    /// depending on the ResourceType.
    resource_id: ?[]const u8 = null,

    /// The name of the template used to create the snapshot.
    resource_snapshot_template_name: ?[]const u8 = null,

    /// The type of resource snapshotted.
    resource_type: ?ResourceType = null,

    /// The revision number of the snapshot. This integer value is incremented each
    /// time the snapshot is updated, allowing for version tracking of the resource
    /// snapshot.
    revision: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .resource_id = "ResourceId",
        .resource_snapshot_template_name = "ResourceSnapshotTemplateName",
        .resource_type = "ResourceType",
        .revision = "Revision",
    };
};
