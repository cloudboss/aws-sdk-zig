const TagValue = @import("tag_value.zig").TagValue;

/// A filter for tags. Only one value can be provided.
pub const TagFilter = union(enum) {
    /// Object containing tag key and value information.
    equal_to: ?TagValue,

    pub const json_field_names = .{
        .equal_to = "equalTo",
    };
};
