/// Describes additional settings for a stateful rule.
pub const RuleOption = struct {
    /// The Suricata keyword.
    keyword: ?[]const u8,

    /// The settings for the keyword.
    settings: ?[]const []const u8,
};
