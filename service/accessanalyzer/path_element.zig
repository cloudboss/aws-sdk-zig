const Substring = @import("substring.zig").Substring;

/// A single element in a path through the JSON representation of a policy.
pub const PathElement = union(enum) {
    /// Refers to an index in a JSON array.
    index: ?i32,
    /// Refers to a key in a JSON object.
    key: ?[]const u8,
    /// Refers to a substring of a literal string in a JSON object.
    substring: ?Substring,
    /// Refers to the value associated with a given key in a JSON object.
    value: ?[]const u8,

    pub const json_field_names = .{
        .index = "index",
        .key = "key",
        .substring = "substring",
        .value = "value",
    };
};
