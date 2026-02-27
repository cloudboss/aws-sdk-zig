const FlattenedElement = @import("flattened_element.zig").FlattenedElement;

/// This processor takes a list of objects that contain key fields, and converts
/// them into a
/// map of target keys.
///
/// For more information about this processor including examples, see [
/// listToMap](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation-Processors.html#CloudWatch-Logs-Transformation-listToMap) in the *CloudWatch Logs User Guide*.
pub const ListToMap = struct {
    /// A Boolean value to indicate whether the list will be flattened into single
    /// items. Specify
    /// `true` to flatten the list. The default is `false`
    flatten: bool = false,

    /// If you set `flatten` to `true`, use `flattenedElement` to
    /// specify which element, `first` or `last`, to keep.
    ///
    /// You must specify this parameter if `flatten` is `true`
    flattened_element: ?FlattenedElement,

    /// The key of the field to be extracted as keys in the generated map
    key: []const u8,

    /// The key in the log event that has a list of objects that will be converted
    /// to a
    /// map.
    source: []const u8,

    /// The key of the field that will hold the generated map
    target: ?[]const u8,

    /// If this is specified, the values that you specify in this parameter will be
    /// extracted from
    /// the `source` objects and put into the values of the generated map.
    /// Otherwise,
    /// original objects in the source list will be put into the values of the
    /// generated map.
    value_key: ?[]const u8,

    pub const json_field_names = .{
        .flatten = "flatten",
        .flattened_element = "flattenedElement",
        .key = "key",
        .source = "source",
        .target = "target",
        .value_key = "valueKey",
    };
};
