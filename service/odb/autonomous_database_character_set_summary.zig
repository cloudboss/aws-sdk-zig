/// A summary of an available character set for Autonomous Databases.
pub const AutonomousDatabaseCharacterSetSummary = struct {
    /// The name of the character set.
    character_set: ?[]const u8 = null,

    pub const json_field_names = .{
        .character_set = "characterSet",
    };
};
