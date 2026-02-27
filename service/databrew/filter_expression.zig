const aws = @import("aws");

/// Represents a structure for defining parameter conditions. Supported
/// conditions are described
/// here: [Supported
/// conditions for dynamic
/// datasets](https://docs.aws.amazon.com/databrew/latest/dg/datasets.multiple-files.html#conditions.for.dynamic.datasets) in the
/// *Glue DataBrew Developer Guide*.
pub const FilterExpression = struct {
    /// The expression which includes condition names followed by substitution
    /// variables, possibly grouped
    /// and combined with other conditions. For example, "(starts_with :prefix1 or
    /// starts_with :prefix2) and
    /// (ends_with :suffix1 or ends_with :suffix2)". Substitution variables should
    /// start with ':' symbol.
    expression: []const u8,

    /// The map of substitution variable names to their values used in this filter
    /// expression.
    values_map: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .expression = "Expression",
        .values_map = "ValuesMap",
    };
};
