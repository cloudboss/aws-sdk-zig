const GenericDataRelationshipType = @import("generic_data_relationship_type.zig").GenericDataRelationshipType;

/// Describes the relationship between generic data models.
pub const CodegenGenericDataRelationshipType = struct {
    /// The associated fields of the data relationship.
    associated_fields: ?[]const []const u8,

    /// The value of the `belongsTo` field on the related data model.
    belongs_to_field_on_related_model: ?[]const u8,

    /// Specifies whether the relationship can unlink the associated model.
    can_unlink_associated_model: ?bool,

    /// Specifies whether the `@index` directive is supported for a `hasMany` data
    /// relationship.
    is_has_many_index: ?bool,

    /// The name of the related join field in the data relationship.
    related_join_field_name: ?[]const u8,

    /// The name of the related join table in the data relationship.
    related_join_table_name: ?[]const u8,

    /// The related model fields in the data relationship.
    related_model_fields: ?[]const []const u8,

    /// The name of the related model in the data relationship.
    related_model_name: []const u8,

    /// The data relationship type.
    @"type": GenericDataRelationshipType,

    pub const json_field_names = .{
        .associated_fields = "associatedFields",
        .belongs_to_field_on_related_model = "belongsToFieldOnRelatedModel",
        .can_unlink_associated_model = "canUnlinkAssociatedModel",
        .is_has_many_index = "isHasManyIndex",
        .related_join_field_name = "relatedJoinFieldName",
        .related_join_table_name = "relatedJoinTableName",
        .related_model_fields = "relatedModelFields",
        .related_model_name = "relatedModelName",
        .@"type" = "type",
    };
};
