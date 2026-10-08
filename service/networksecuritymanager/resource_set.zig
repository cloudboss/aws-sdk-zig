const ResourceLogicalExpression = @import("resource_logical_expression.zig").ResourceLogicalExpression;

/// A set of resources defined by explicit ARNs, a logical expression, or both.
pub const ResourceSet = struct {
    /// An explicit list of resource ARNs.
    explicit_arns: ?[]const []const u8 = null,

    /// A logical expression that selects resources by combining criteria with AND,
    /// OR, and NOT operators.
    expression: ?ResourceLogicalExpression = null,

    pub const json_field_names = .{
        .explicit_arns = "explicitArns",
        .expression = "expression",
    };
};
