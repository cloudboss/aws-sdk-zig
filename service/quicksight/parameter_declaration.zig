const DateTimeParameterDeclaration = @import("date_time_parameter_declaration.zig").DateTimeParameterDeclaration;
const DecimalParameterDeclaration = @import("decimal_parameter_declaration.zig").DecimalParameterDeclaration;
const IntegerParameterDeclaration = @import("integer_parameter_declaration.zig").IntegerParameterDeclaration;
const StringParameterDeclaration = @import("string_parameter_declaration.zig").StringParameterDeclaration;

/// The declaration definition of a parameter.
///
/// For more information, see [Parameters in Amazon Quick
/// Sight](https://docs.aws.amazon.com/quicksight/latest/user/parameters-in-quicksight.html) in the *Amazon Quick Suite User Guide*.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const ParameterDeclaration = struct {
    /// A parameter declaration for the `DateTime` data type.
    date_time_parameter_declaration: ?DateTimeParameterDeclaration = null,

    /// A parameter declaration for the `Decimal` data type.
    decimal_parameter_declaration: ?DecimalParameterDeclaration = null,

    /// A parameter declaration for the `Integer` data type.
    integer_parameter_declaration: ?IntegerParameterDeclaration = null,

    /// A parameter declaration for the `String` data type.
    string_parameter_declaration: ?StringParameterDeclaration = null,

    pub const json_field_names = .{
        .date_time_parameter_declaration = "DateTimeParameterDeclaration",
        .decimal_parameter_declaration = "DecimalParameterDeclaration",
        .integer_parameter_declaration = "IntegerParameterDeclaration",
        .string_parameter_declaration = "StringParameterDeclaration",
    };
};
