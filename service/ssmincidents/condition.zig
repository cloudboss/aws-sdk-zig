const AttributeValueList = @import("attribute_value_list.zig").AttributeValueList;

/// A conditional statement with which to compare a value, after a timestamp,
/// before a
/// timestamp, or equal to a string or integer. If multiple conditions are
/// specified, the
/// conditionals become an `AND`ed statement. If multiple values are specified
/// for a
/// conditional, the values are `OR`d.
pub const Condition = union(enum) {
    /// After the specified timestamp.
    after: ?i64,
    /// Before the specified timestamp
    before: ?i64,
    /// The value is equal to the provided string or integer.
    equals: ?AttributeValueList,

    pub const json_field_names = .{
        .after = "after",
        .before = "before",
        .equals = "equals",
    };
};
