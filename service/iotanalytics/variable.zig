const DatasetContentVersionValue = @import("dataset_content_version_value.zig").DatasetContentVersionValue;
const OutputFileUriValue = @import("output_file_uri_value.zig").OutputFileUriValue;

/// An instance of a variable to be passed to the `containerAction` execution.
/// Each
/// variable must have a name and a value given by one of `stringValue`,
/// `datasetContentVersionValue`, or `outputFileUriValue`.
pub const Variable = struct {
    /// The value of the variable as a structure that specifies a dataset content
    /// version.
    dataset_content_version_value: ?DatasetContentVersionValue = null,

    /// The value of the variable as a double (numeric).
    double_value: ?f64 = null,

    /// The name of the variable.
    name: []const u8,

    /// The value of the variable as a structure that specifies an output file URI.
    output_file_uri_value: ?OutputFileUriValue = null,

    /// The value of the variable as a string.
    string_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_content_version_value = "datasetContentVersionValue",
        .double_value = "doubleValue",
        .name = "name",
        .output_file_uri_value = "outputFileUriValue",
        .string_value = "stringValue",
    };
};
