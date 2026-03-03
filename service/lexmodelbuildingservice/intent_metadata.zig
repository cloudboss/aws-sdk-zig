/// Provides information about an intent.
pub const IntentMetadata = struct {
    /// The date that the intent was created.
    created_date: ?i64 = null,

    /// A description of the intent.
    description: ?[]const u8 = null,

    /// The date that the intent was updated. When you create an intent,
    /// the creation date and last updated date are the same.
    last_updated_date: ?i64 = null,

    /// The name of the intent.
    name: ?[]const u8 = null,

    /// The version of the intent.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .version = "version",
    };
};
