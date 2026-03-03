/// Describes an Glue usage profile.
pub const UsageProfileDefinition = struct {
    /// The date and time when the usage profile was created.
    created_on: ?i64 = null,

    /// A description of the usage profile.
    description: ?[]const u8 = null,

    /// The date and time when the usage profile was last modified.
    last_modified_on: ?i64 = null,

    /// The name of the usage profile.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_on = "CreatedOn",
        .description = "Description",
        .last_modified_on = "LastModifiedOn",
        .name = "Name",
    };
};
