const MigrationAlertType = @import("migration_alert_type.zig").MigrationAlertType;

/// Provides information about alerts and warnings that Amazon Lex sends during
/// a migration. The alerts include information about how to resolve the
/// issue.
pub const MigrationAlert = struct {
    /// Additional details about the alert.
    details: ?[]const []const u8 = null,

    /// A message that describes why the alert was issued.
    message: ?[]const u8 = null,

    /// A link to the Amazon Lex documentation that describes how to resolve
    /// the alert.
    reference_ur_ls: ?[]const []const u8 = null,

    /// The type of alert. There are two kinds of alerts:
    ///
    /// * `ERROR` - There was an issue with the migration that
    /// can't be resolved. The migration stops.
    ///
    /// * `WARN` - There was an issue with the migration that
    /// requires manual changes to the new Amazon Lex V2 bot. The migration
    /// continues.
    @"type": ?MigrationAlertType = null,

    pub const json_field_names = .{
        .details = "details",
        .message = "message",
        .reference_ur_ls = "referenceURLs",
        .@"type" = "type",
    };
};
