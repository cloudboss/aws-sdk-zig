/// Provides information about a slot type..
pub const SlotTypeMetadata = struct {
    /// The date that the slot type was created.
    created_date: ?i64,

    /// A description of the slot type.
    description: ?[]const u8,

    /// The date that the slot type was updated. When you create a
    /// resource, the creation date and last updated date are the same.
    last_updated_date: ?i64,

    /// The name of the slot type.
    name: ?[]const u8,

    /// The version of the slot type.
    version: ?[]const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .version = "version",
    };
};
