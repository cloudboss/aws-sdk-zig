const SchemaAttribute = @import("schema_attribute.zig").SchemaAttribute;

/// Defines the fields of a dataset.
pub const Schema = struct {
    /// An array of attributes specifying the name and type of each field in a
    /// dataset.
    attributes: ?[]const SchemaAttribute,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};
