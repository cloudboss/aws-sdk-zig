/// An object that contains metadata and details about the entity.
pub const EntityDetail = struct {
    /// An object that contains all the details of the entity.
    details_document: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the entity.
    entity_arn: ?[]const u8,

    /// The ID of the entity, in the format of `EntityId@RevisionId`.
    entity_identifier: ?[]const u8,

    /// The entity type of the entity, in the format of
    /// `EntityType@Version`.
    entity_type: ?[]const u8,

    /// The last time the entity was modified.
    last_modified_date: ?[]const u8,

    pub const json_field_names = .{
        .details_document = "DetailsDocument",
        .entity_arn = "EntityArn",
        .entity_identifier = "EntityIdentifier",
        .entity_type = "EntityType",
        .last_modified_date = "LastModifiedDate",
    };
};
