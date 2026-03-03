/// Specifies a grok classifier to update when passed to
/// `UpdateClassifier`.
pub const UpdateGrokClassifierRequest = struct {
    /// An identifier of the data format that the classifier matches, such as
    /// Twitter, JSON, Omniture logs,
    /// Amazon CloudWatch Logs, and so on.
    classification: ?[]const u8 = null,

    /// Optional custom grok patterns used by this classifier.
    custom_patterns: ?[]const u8 = null,

    /// The grok pattern used by this classifier.
    grok_pattern: ?[]const u8 = null,

    /// The name of the `GrokClassifier`.
    name: []const u8,

    pub const json_field_names = .{
        .classification = "Classification",
        .custom_patterns = "CustomPatterns",
        .grok_pattern = "GrokPattern",
        .name = "Name",
    };
};
