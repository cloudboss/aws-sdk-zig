const StatementProperties = @import("statement_properties.zig").StatementProperties;

/// The properties of the metadata model.
pub const MetadataModelProperties = union(enum) {
    /// The properties of the SQL statement.
    statement_properties: ?StatementProperties,

    pub const json_field_names = .{
        .statement_properties = "StatementProperties",
    };
};
