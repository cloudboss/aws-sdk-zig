/// The pattern configuration for redacting custom data types in session.
pub const CustomPattern = struct {
    /// The keyword regex for the customer pattern. After there is a match to the
    /// pattern regex, the keyword regex is used to search within the proximity of
    /// the match. If there is a keyword match, then the match is confirmed. If no
    /// keyword regex is provided, the pattern regex match will automatically be
    /// confirmed. The format must follow JavaScript regex format. The pattern must
    /// be enclosed between slashes, and can have flags behind the second slash. For
    /// example, “/ab+c/gi”
    keyword_regex: ?[]const u8,

    /// The pattern description for the customer pattern.
    pattern_description: ?[]const u8,

    /// The pattern name for the custom pattern.
    pattern_name: []const u8,

    /// The pattern regex for the customer pattern. The format must follow
    /// JavaScript regex format. The pattern must be enclosed between slashes, and
    /// can have flags behind the second slash. For example: “/ab+c/gi”.
    pattern_regex: []const u8,

    pub const json_field_names = .{
        .keyword_regex = "keywordRegex",
        .pattern_description = "patternDescription",
        .pattern_name = "patternName",
        .pattern_regex = "patternRegex",
    };
};
