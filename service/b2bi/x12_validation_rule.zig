const X12CodeListValidationRule = @import("x12_code_list_validation_rule.zig").X12CodeListValidationRule;
const X12ElementLengthValidationRule = @import("x12_element_length_validation_rule.zig").X12ElementLengthValidationRule;
const X12ElementRequirementValidationRule = @import("x12_element_requirement_validation_rule.zig").X12ElementRequirementValidationRule;

/// Represents a single validation rule that can be applied during X12 EDI
/// processing. This is a union type that can contain one of several specific
/// validation rule types: code list validation rules for modifying allowed
/// element codes, element length validation rules for enforcing custom length
/// constraints, or element requirement validation rules for changing
/// mandatory/optional status. Each validation rule targets specific aspects of
/// EDI document validation to ensure compliance with trading partner
/// requirements and business rules.
pub const X12ValidationRule = union(enum) {
    /// Specifies a code list validation rule that modifies the allowed code values
    /// for a specific X12 element. This rule enables you to customize which codes
    /// are considered valid for an element, allowing for trading partner-specific
    /// code requirements.
    code_list_validation_rule: ?X12CodeListValidationRule,
    /// Specifies an element length validation rule that defines custom length
    /// constraints for a specific X12 element. This rule allows you to enforce
    /// minimum and maximum length requirements that may differ from the standard
    /// X12 specification.
    element_length_validation_rule: ?X12ElementLengthValidationRule,
    /// Specifies an element requirement validation rule that modifies whether a
    /// specific X12 element is required or optional within a segment. This rule
    /// provides flexibility to accommodate different trading partner requirements
    /// for element presence.
    element_requirement_validation_rule: ?X12ElementRequirementValidationRule,

    pub const json_field_names = .{
        .code_list_validation_rule = "codeListValidationRule",
        .element_length_validation_rule = "elementLengthValidationRule",
        .element_requirement_validation_rule = "elementRequirementValidationRule",
    };
};
