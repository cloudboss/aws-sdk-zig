/// A classifier for `JSON` content.
pub const JsonClassifier = struct {
    /// The time that this classifier was registered.
    creation_time: ?i64,

    /// A `JsonPath` string defining the JSON data for the classifier to classify.
    /// Glue supports a subset of JsonPath, as described in [Writing JsonPath Custom
    /// Classifiers](https://docs.aws.amazon.com/glue/latest/dg/custom-classifier.html#custom-classifier-json).
    json_path: []const u8,

    /// The time that this classifier was last updated.
    last_updated: ?i64,

    /// The name of the classifier.
    name: []const u8,

    /// The version of this classifier.
    version: i64 = 0,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .json_path = "JsonPath",
        .last_updated = "LastUpdated",
        .name = "Name",
        .version = "Version",
    };
};
