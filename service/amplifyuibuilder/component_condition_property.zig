const ComponentProperty = @import("component_property.zig").ComponentProperty;

/// Represents a conditional expression to set a component property. Use
/// `ComponentConditionProperty` to set a property to different values
/// conditionally,
/// based on the value of another property.
pub const ComponentConditionProperty = struct {
    /// The value to assign to the property if the condition is not met.
    @"else": ?*ComponentProperty = null,

    /// The name of a field. Specify this when the property is a data model.
    field: ?[]const u8,

    /// The value of the property to evaluate.
    operand: ?[]const u8,

    /// The type of the property to evaluate.
    operand_type: ?[]const u8,

    /// The operator to use to perform the evaluation, such as `eq` to represent
    /// equals.
    operator: ?[]const u8,

    /// The name of the conditional property.
    property: ?[]const u8,

    /// The value to assign to the property if the condition is met.
    then: ?*ComponentProperty = null,

    pub const json_field_names = .{
        .@"else" = "else",
        .field = "field",
        .operand = "operand",
        .operand_type = "operandType",
        .operator = "operator",
        .property = "property",
        .then = "then",
    };
};
