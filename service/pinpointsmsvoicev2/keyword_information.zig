const KeywordAction = @import("keyword_action.zig").KeywordAction;

/// The information for all keywords in a pool.
pub const KeywordInformation = struct {
    /// The keyword as a string.
    keyword: []const u8,

    /// The action to perform for the keyword.
    keyword_action: KeywordAction,

    /// A custom message that can be used with the keyword.
    keyword_message: []const u8,

    pub const json_field_names = .{
        .keyword = "Keyword",
        .keyword_action = "KeywordAction",
        .keyword_message = "KeywordMessage",
    };
};
