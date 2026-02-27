/// Provides information about an intent.
pub const IntentMetadata = struct {
    /// The date that the intent was created.
    created_date: ?i64,

    /// A description of the intent.
    description: ?[]const u8,

    /// The date that the intent was updated. When you create an intent,
    /// the creation date and last updated date are the same.
    last_updated_date: ?i64,

    /// The name of the intent.
    name: ?[]const u8,

    /// The version of the intent.
    version: ?[]const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .version = "version",
    };
};
