const InstancePropertyFilterKey = @import("instance_property_filter_key.zig").InstancePropertyFilterKey;

/// Describes a filter for a specific list of managed nodes. You can filter node
/// information by
/// using tags. You specify tags by using a key-value mapping.
pub const InstancePropertyFilter = struct {
    /// The name of the filter.
    key: InstancePropertyFilterKey,

    /// The filter values.
    value_set: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value_set = "valueSet",
    };
};
