/// Specifies a JSON classifier to be updated.
pub const UpdateJsonClassifierRequest = struct {
    /// A `JsonPath` string defining the JSON data for the classifier to classify.
    /// Glue supports a subset of JsonPath, as described in [Writing JsonPath Custom
    /// Classifiers](https://docs.aws.amazon.com/glue/latest/dg/custom-classifier.html#custom-classifier-json).
    json_path: ?[]const u8 = null,

    /// The name of the classifier.
    name: []const u8,

    pub const json_field_names = .{
        .json_path = "JsonPath",
        .name = "Name",
    };
};
