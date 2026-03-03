/// An object that defines the log patterns that belongs to a
/// `LogPatternSet`.
pub const LogPattern = struct {
    /// A regular expression that defines the log pattern. A log pattern can contain
    /// as many as
    /// 50 characters, and it cannot be empty. The pattern must be DFA compatible.
    /// Patterns that
    /// utilize forward lookahead or backreference constructions are not supported.
    pattern: ?[]const u8 = null,

    /// The name of the log pattern. A log pattern name can contain as many as 50
    /// characters,
    /// and it cannot be empty. The characters can be Unicode letters, digits, or
    /// one of the
    /// following symbols: period, dash, underscore.
    pattern_name: ?[]const u8 = null,

    /// The name of the log pattern. A log pattern name can contain as many as 30
    /// characters,
    /// and it cannot be empty. The characters can be Unicode letters, digits, or
    /// one of the
    /// following symbols: period, dash, underscore.
    pattern_set_name: ?[]const u8 = null,

    /// Rank of the log pattern. Must be a value between `1` and
    /// `1,000,000`. The patterns are sorted by rank, so we recommend that you set
    /// your highest priority patterns with the lowest rank. A pattern of rank `1`
    /// will
    /// be the first to get matched to a log line. A pattern of rank `1,000,000`
    /// will be
    /// last to get matched. When you configure custom log patterns from the
    /// console, a
    /// `Low` severity pattern translates to a `750,000` rank. A
    /// `Medium` severity pattern translates to a `500,000` rank. And a
    /// `High` severity pattern translates to a `250,000` rank. Rank
    /// values less than `1` or greater than `1,000,000` are reserved for
    /// Amazon Web Services provided patterns.
    rank: i32 = 0,

    pub const json_field_names = .{
        .pattern = "Pattern",
        .pattern_name = "PatternName",
        .pattern_set_name = "PatternSetName",
        .rank = "Rank",
    };
};
