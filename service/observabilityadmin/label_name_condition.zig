/// Condition that matches based on WAF rule labels, with label names limited to
/// 1024 characters.
pub const LabelNameCondition = struct {
    /// The label name to match, supporting alphanumeric characters, underscores,
    /// hyphens, and colons.
    label_name: ?[]const u8,

    pub const json_field_names = .{
        .label_name = "LabelName",
    };
};
