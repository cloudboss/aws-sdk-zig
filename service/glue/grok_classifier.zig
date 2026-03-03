/// A classifier that uses `grok` patterns.
pub const GrokClassifier = struct {
    /// An identifier of the data format that the classifier matches, such as
    /// Twitter, JSON, Omniture logs, and
    /// so on.
    classification: []const u8,

    /// The time that this classifier was registered.
    creation_time: ?i64 = null,

    /// Optional custom grok patterns defined by this classifier.
    /// For more information, see custom patterns in [Writing Custom
    /// Classifiers](https://docs.aws.amazon.com/glue/latest/dg/custom-classifier.html).
    custom_patterns: ?[]const u8 = null,

    /// The grok pattern applied to a data store by this classifier.
    /// For more information, see built-in patterns in [Writing Custom
    /// Classifiers](https://docs.aws.amazon.com/glue/latest/dg/custom-classifier.html).
    grok_pattern: []const u8,

    /// The time that this classifier was last updated.
    last_updated: ?i64 = null,

    /// The name of the classifier.
    name: []const u8,

    /// The version of this classifier.
    version: i64 = 0,

    pub const json_field_names = .{
        .classification = "Classification",
        .creation_time = "CreationTime",
        .custom_patterns = "CustomPatterns",
        .grok_pattern = "GrokPattern",
        .last_updated = "LastUpdated",
        .name = "Name",
        .version = "Version",
    };
};
