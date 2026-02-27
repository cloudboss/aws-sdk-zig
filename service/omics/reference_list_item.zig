const ReferenceStatus = @import("reference_status.zig").ReferenceStatus;

/// A genome reference.
pub const ReferenceListItem = struct {
    /// The reference's ARN.
    arn: []const u8,

    /// When the reference was created.
    creation_time: i64,

    /// The reference's description.
    description: ?[]const u8,

    /// The reference's ID.
    id: []const u8,

    /// The reference's MD5 checksum.
    md_5: []const u8,

    /// The reference's name.
    name: ?[]const u8,

    /// The reference's store ID.
    reference_store_id: []const u8,

    /// The reference's status.
    status: ?ReferenceStatus,

    /// When the reference was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .md_5 = "md5",
        .name = "name",
        .reference_store_id = "referenceStoreId",
        .status = "status",
        .update_time = "updateTime",
    };
};
