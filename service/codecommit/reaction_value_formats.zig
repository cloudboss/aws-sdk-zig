/// Information about the values for reactions to a comment. CodeCommit supports
/// a limited set of reactions.
pub const ReactionValueFormats = struct {
    /// The Emoji Version 1.0 graphic of the reaction. These graphics are
    /// interpreted slightly differently on different operating systems.
    emoji: ?[]const u8,

    /// The emoji short code for the reaction. Short codes are interpreted slightly
    /// differently on different operating systems.
    short_code: ?[]const u8,

    /// The Unicode codepoint for the reaction.
    unicode: ?[]const u8,

    pub const json_field_names = .{
        .emoji = "emoji",
        .short_code = "shortCode",
        .unicode = "unicode",
    };
};
