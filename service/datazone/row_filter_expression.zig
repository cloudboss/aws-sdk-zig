const EqualToExpression = @import("equal_to_expression.zig").EqualToExpression;
const GreaterThanExpression = @import("greater_than_expression.zig").GreaterThanExpression;
const GreaterThanOrEqualToExpression = @import("greater_than_or_equal_to_expression.zig").GreaterThanOrEqualToExpression;
const InExpression = @import("in_expression.zig").InExpression;
const IsNotNullExpression = @import("is_not_null_expression.zig").IsNotNullExpression;
const IsNullExpression = @import("is_null_expression.zig").IsNullExpression;
const LessThanExpression = @import("less_than_expression.zig").LessThanExpression;
const LessThanOrEqualToExpression = @import("less_than_or_equal_to_expression.zig").LessThanOrEqualToExpression;
const LikeExpression = @import("like_expression.zig").LikeExpression;
const NotEqualToExpression = @import("not_equal_to_expression.zig").NotEqualToExpression;
const NotInExpression = @import("not_in_expression.zig").NotInExpression;
const NotLikeExpression = @import("not_like_expression.zig").NotLikeExpression;

/// The row filter expression.
pub const RowFilterExpression = union(enum) {
    /// The 'equal to' clause of the row filter expression.
    equal_to: ?EqualToExpression,
    /// The 'greater than' clause of the row filter expression.
    greater_than: ?GreaterThanExpression,
    /// The 'greater than or equal to' clause of the filter expression.
    greater_than_or_equal_to: ?GreaterThanOrEqualToExpression,
    /// The 'in' clause of the row filter expression.
    in: ?InExpression,
    /// The 'is not null' clause of the row filter expression.
    is_not_null: ?IsNotNullExpression,
    /// The 'is null' clause of the row filter expression.
    is_null: ?IsNullExpression,
    /// The 'less than' clause of the row filter expression.
    less_than: ?LessThanExpression,
    /// The 'less than or equal to' clause of the row filter expression.
    less_than_or_equal_to: ?LessThanOrEqualToExpression,
    /// The 'like' clause of the row filter expression.
    like: ?LikeExpression,
    /// The 'no equal to' clause of the row filter expression.
    not_equal_to: ?NotEqualToExpression,
    /// The 'not in' clause of the row filter expression.
    not_in: ?NotInExpression,
    /// The 'not like' clause of the row filter expression.
    not_like: ?NotLikeExpression,

    pub const json_field_names = .{
        .equal_to = "equalTo",
        .greater_than = "greaterThan",
        .greater_than_or_equal_to = "greaterThanOrEqualTo",
        .in = "in",
        .is_not_null = "isNotNull",
        .is_null = "isNull",
        .less_than = "lessThan",
        .less_than_or_equal_to = "lessThanOrEqualTo",
        .like = "like",
        .not_equal_to = "notEqualTo",
        .not_in = "notIn",
        .not_like = "notLike",
    };
};
