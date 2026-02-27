/// Specifies a character set.
pub const CharacterSet = struct {
    /// The description of the character set.
    character_set_description: ?[]const u8,

    /// The name of the character set.
    character_set_name: ?[]const u8,
};
