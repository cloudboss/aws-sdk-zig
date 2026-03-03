const MigrationStatus = @import("migration_status.zig").MigrationStatus;
const MigrationStrategy = @import("migration_strategy.zig").MigrationStrategy;
const Locale = @import("locale.zig").Locale;

/// Provides information about migrating a bot from Amazon Lex V1 to Amazon Lex
/// V2.
pub const MigrationSummary = struct {
    /// The unique identifier that Amazon Lex assigned to the migration.
    migration_id: ?[]const u8 = null,

    /// The status of the operation. When the status is `COMPLETE`
    /// the bot is available in Amazon Lex V2. There may be alerts and warnings that
    /// need to be resolved to complete the migration.
    migration_status: ?MigrationStatus = null,

    /// The strategy used to conduct the migration.
    migration_strategy: ?MigrationStrategy = null,

    /// The date and time that the migration started.
    migration_timestamp: ?i64 = null,

    /// The locale of the Amazon Lex V1 bot that is the source of the migration.
    v_1_bot_locale: ?Locale = null,

    /// The name of the Amazon Lex V1 bot that is the source of the migration.
    v_1_bot_name: ?[]const u8 = null,

    /// The version of the Amazon Lex V1 bot that is the source of the migration.
    v_1_bot_version: ?[]const u8 = null,

    /// The unique identifier of the Amazon Lex V2 that is the destination of the
    /// migration.
    v_2_bot_id: ?[]const u8 = null,

    /// The IAM role that Amazon Lex uses to run the Amazon Lex V2 bot.
    v_2_bot_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .migration_id = "migrationId",
        .migration_status = "migrationStatus",
        .migration_strategy = "migrationStrategy",
        .migration_timestamp = "migrationTimestamp",
        .v_1_bot_locale = "v1BotLocale",
        .v_1_bot_name = "v1BotName",
        .v_1_bot_version = "v1BotVersion",
        .v_2_bot_id = "v2BotId",
        .v_2_bot_role = "v2BotRole",
    };
};
