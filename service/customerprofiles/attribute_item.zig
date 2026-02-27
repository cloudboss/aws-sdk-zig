/// The details of a single attribute item specified in the mathematical
/// expression.
pub const AttributeItem = struct {
    /// The name of an attribute defined in a profile object type.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
