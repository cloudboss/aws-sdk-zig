const ConditionalBehavior = @import("conditional_behavior.zig").ConditionalBehavior;
const RegistrationFieldDisplayHints = @import("registration_field_display_hints.zig").RegistrationFieldDisplayHints;
const FieldRequirement = @import("field_requirement.zig").FieldRequirement;
const FieldType = @import("field_type.zig").FieldType;
const SelectValidation = @import("select_validation.zig").SelectValidation;
const TextValidation = @import("text_validation.zig").TextValidation;

/// Provides a description of the specified field.
pub const RegistrationFieldDefinition = struct {
    /// The conditional behavior rules for this field. Only present when
    /// **FieldRequirement** is **CONDITIONAL**. Rules are evaluated in order and
    /// the first matching rule determines the field's resolved requirement. If no
    /// rule matches, the **DefaultBehavior** applies.
    conditional_behavior: ?ConditionalBehavior = null,

    /// An array of RegistrationFieldDisplayHints objects for the field.
    display_hints: RegistrationFieldDisplayHints,

    /// The path to the registration form field. You can use
    /// DescribeRegistrationFieldDefinitions for a list of **FieldPaths**.
    field_path: []const u8,

    /// Specifies if the field for the registration form is required, conditional or
    /// optional.
    field_requirement: FieldRequirement,

    /// The type of field.
    field_type: FieldType,

    /// The section path of the field.
    section_path: []const u8,

    /// The validation rules for a select field.
    select_validation: ?SelectValidation = null,

    /// The validation rules for a text field.
    text_validation: ?TextValidation = null,

    pub const json_field_names = .{
        .conditional_behavior = "ConditionalBehavior",
        .display_hints = "DisplayHints",
        .field_path = "FieldPath",
        .field_requirement = "FieldRequirement",
        .field_type = "FieldType",
        .section_path = "SectionPath",
        .select_validation = "SelectValidation",
        .text_validation = "TextValidation",
    };
};
