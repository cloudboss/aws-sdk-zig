const Filter = @import("filter.zig").Filter;
const NestedFilters = @import("nested_filters.zig").NestedFilters;
const BooleanOperator = @import("boolean_operator.zig").BooleanOperator;

/// A multi-expression that searches for the specified resource or resources in
/// a search. All resource objects that satisfy the expression's condition are
/// included in the search results. You must specify at least one subexpression,
/// filter, or nested filter. A `SearchExpression` can contain up to twenty
/// elements.
///
/// A `SearchExpression` contains the following components:
///
/// * A list of `Filter` objects. Each filter defines a simple Boolean
///   expression comprised of a resource property name, Boolean operator, and
///   value.
/// * A list of `NestedFilter` objects. Each nested filter defines a list of
///   Boolean expressions using a list of resource properties. A nested filter
///   is satisfied if a single object in the list satisfies all Boolean
///   expressions.
/// * A list of `SearchExpression` objects. A search expression object can be
///   nested in a list of search expression objects.
/// * A Boolean operator: `And` or `Or`.
pub const SearchExpression = struct {
    /// A list of filter objects.
    filters: ?[]const Filter = null,

    /// A list of nested filter objects.
    nested_filters: ?[]const NestedFilters = null,

    /// A Boolean operator used to evaluate the search expression. If you want every
    /// conditional statement in all lists to be satisfied for the entire search
    /// expression to be true, specify `And`. If only a single conditional statement
    /// needs to be true for the entire search expression to be true, specify `Or`.
    /// The default value is `And`.
    operator: ?BooleanOperator = null,

    /// A list of search expression objects.
    sub_expressions: ?[]const SearchExpression = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .nested_filters = "NestedFilters",
        .operator = "Operator",
        .sub_expressions = "SubExpressions",
    };
};
