/// A partition dimension defined by an attribute.
pub const Partition = struct {
    /// The name of the attribute that defines a partition dimension.
    attribute_name: []const u8,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
    };
};
