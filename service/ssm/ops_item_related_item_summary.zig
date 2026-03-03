const OpsItemIdentity = @import("ops_item_identity.zig").OpsItemIdentity;

/// Summary information about related-item resources for an OpsItem.
pub const OpsItemRelatedItemSummary = struct {
    /// The association ID.
    association_id: ?[]const u8 = null,

    /// The association type.
    association_type: ?[]const u8 = null,

    created_by: ?OpsItemIdentity = null,

    /// The time the related-item association was created.
    created_time: ?i64 = null,

    last_modified_by: ?OpsItemIdentity = null,

    /// The time the related-item association was last updated.
    last_modified_time: ?i64 = null,

    /// The OpsItem ID.
    ops_item_id: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the related-item resource.
    resource_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .association_type = "AssociationType",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .ops_item_id = "OpsItemId",
        .resource_type = "ResourceType",
        .resource_uri = "ResourceUri",
    };
};
