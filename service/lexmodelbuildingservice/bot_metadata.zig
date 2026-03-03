const Status = @import("status.zig").Status;

/// Provides information about a bot. .
pub const BotMetadata = struct {
    /// The date that the bot was created.
    created_date: ?i64 = null,

    /// A description of the bot.
    description: ?[]const u8 = null,

    /// The date that the bot was updated. When you create a bot, the
    /// creation date and last updated date are the same.
    last_updated_date: ?i64 = null,

    /// The name of the bot.
    name: ?[]const u8 = null,

    /// The status of the bot.
    status: ?Status = null,

    /// The version of the bot. For a new bot, the version is always
    /// `$LATEST`.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .status = "status",
        .version = "version",
    };
};
