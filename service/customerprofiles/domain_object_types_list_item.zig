const aws = @import("aws");

/// Represents an item in the list of domain object types, containing basic
/// information about a specific object type within a domain.
pub const DomainObjectTypesListItem = struct {
    /// The timestamp of when the domain object type was created.
    created_at: ?i64,

    /// A description explaining the purpose and characteristics of this object
    /// type.
    description: ?[]const u8,

    /// The timestamp of when the domain object type was most recently edited.
    last_updated_at: ?i64,

    /// The name that identifies the object type within the domain.
    object_type_name: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .tags = "Tags",
    };
};
