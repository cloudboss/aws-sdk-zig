const Operator = @import("operator.zig").Operator;

/// A comparision that is used to determine whether a query should return this
/// object.
pub const Selector = struct {
    /// The name of the field that the operator will be applied to. The field name
    /// is the "key" portion of the field definition in the pipeline definition
    /// syntax that is used by the AWS Data Pipeline API. If the field is not set on
    /// the object, the condition fails.
    field_name: ?[]const u8,

    operator: ?Operator,

    pub const json_field_names = .{
        .field_name = "fieldName",
        .operator = "operator",
    };
};
