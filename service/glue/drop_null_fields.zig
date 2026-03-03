const NullCheckBoxList = @import("null_check_box_list.zig").NullCheckBoxList;
const NullValueField = @import("null_value_field.zig").NullValueField;

/// Specifies a transform that removes columns from the dataset if all values in
/// the column are 'null'. By default, Glue Studio will recognize null objects,
/// but some values such as empty strings, strings that are "null", -1 integers
/// or other placeholders such as zeros, are not automatically recognized as
/// nulls.
pub const DropNullFields = struct {
    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// A structure that represents whether certain values are recognized as null
    /// values for removal.
    null_check_box_list: ?NullCheckBoxList = null,

    /// A structure that specifies a list of NullValueField structures that
    /// represent a custom null value such as zero or other value being used as a
    /// null placeholder unique to the dataset.
    ///
    /// The `DropNullFields` transform removes custom null values only if both the
    /// value of the null placeholder and the datatype match the data.
    null_text_list: ?[]const NullValueField = null,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .null_check_box_list = "NullCheckBoxList",
        .null_text_list = "NullTextList",
    };
};
