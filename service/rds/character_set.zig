/// This data type is used as a response element in the action
/// `DescribeDBEngineVersions`.
pub const CharacterSet = struct {
    /// The description of the character set.
    character_set_description: ?[]const u8 = null,

    /// The name of the character set.
    character_set_name: ?[]const u8 = null,
};
