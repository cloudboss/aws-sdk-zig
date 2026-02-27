const aws = @import("aws");

/// A ProfileObjectType instance.
pub const ListProfileObjectTypeItem = struct {
    /// The timestamp of when the domain was created.
    created_at: ?i64,

    /// Description of the profile object type.
    description: []const u8,

    /// The timestamp of when the profile object type was most recently edited.
    last_updated_at: ?i64,

    /// The amount of provisioned profile object max count available.
    max_available_profile_object_count: ?i32,

    /// The amount of profile object max count assigned to the object type.
    max_profile_object_count: ?i32,

    /// The name of the profile object type.
    object_type_name: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .last_updated_at = "LastUpdatedAt",
        .max_available_profile_object_count = "MaxAvailableProfileObjectCount",
        .max_profile_object_count = "MaxProfileObjectCount",
        .object_type_name = "ObjectTypeName",
        .tags = "Tags",
    };
};
