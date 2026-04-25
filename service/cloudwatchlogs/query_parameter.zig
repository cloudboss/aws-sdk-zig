/// This structure defines a query parameter for a saved CloudWatch Logs
/// Insights query
/// definition. Query parameters are supported only for Logs Insights QL
/// queries. They are
/// placeholder variables that you can reference in a query string using the
/// `{{parameterName}}` syntax. Each parameter can include a default value and a
/// description.
pub const QueryParameter = struct {
    /// The default value to use for this query parameter if no value is supplied at
    /// execution
    /// time.
    default_value: ?[]const u8 = null,

    /// A description of the query parameter that explains its purpose or expected
    /// values.
    description: ?[]const u8 = null,

    /// The name of the query parameter. A query parameter name must start with a
    /// letter or
    /// underscore, and contain only letters, digits, and underscores.
    name: []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .name = "name",
    };
};
