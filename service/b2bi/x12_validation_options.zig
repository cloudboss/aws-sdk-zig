const X12ValidationRule = @import("x12_validation_rule.zig").X12ValidationRule;

/// Contains configuration options for X12 EDI validation. This structure allows
/// you to specify custom validation rules that will be applied during EDI
/// document processing, including element length constraints, code list
/// modifications, and element requirement changes. These validation options
/// provide flexibility to accommodate trading partner-specific requirements
/// while maintaining EDI compliance. The validation rules are applied in
/// addition to standard X12 validation to ensure documents meet both standard
/// and custom requirements.
pub const X12ValidationOptions = struct {
    /// Specifies a list of validation rules to apply during EDI document
    /// processing. These rules can include code list modifications, element length
    /// constraints, and element requirement changes.
    validation_rules: ?[]const X12ValidationRule,

    pub const json_field_names = .{
        .validation_rules = "validationRules",
    };
};
