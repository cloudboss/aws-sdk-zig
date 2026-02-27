const StatementProperties = @import("statement_properties.zig").StatementProperties;

/// The properties of metadata model in JSON format. This object is a Union.
/// Only one member of this object can be specified or returned.
pub const MetadataModelProperties = union(enum) {
    /// The properties of the statement.
    statement_properties: ?StatementProperties,

    pub const json_field_names = .{
        .statement_properties = "StatementProperties",
    };
};
