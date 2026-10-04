const SpaceQuickSightResource = @import("space_quick_sight_resource.zig").SpaceQuickSightResource;

/// The details of an Amazon QuickSight space.
pub const SpaceDetails = struct {
    /// The number of consumed source documents.
    consumed_source_doc_count: ?i32 = null,

    /// The total consumed source size in bytes.
    consumed_source_size: ?i64 = null,

    /// The date and time that the space was created.
    created_at: ?i64 = null,

    /// The user who created the space.
    created_by: ?[]const u8 = null,

    /// The ARN of the user who created the space.
    created_by_arn: ?[]const u8 = null,

    /// The description of the space.
    description: ?[]const u8 = null,

    /// The display name of the space.
    name: ?[]const u8 = null,

    /// The resources in the space.
    resources: ?[]const SpaceQuickSightResource = null,

    /// The date and time that the space was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .consumed_source_doc_count = "consumedSourceDocCount",
        .consumed_source_size = "consumedSourceSize",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .created_by_arn = "createdByArn",
        .description = "description",
        .name = "name",
        .resources = "resources",
        .updated_at = "updatedAt",
    };
};
