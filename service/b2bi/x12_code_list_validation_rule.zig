/// Defines a validation rule that modifies the allowed code values for a
/// specific X12 element. This rule allows you to add or remove valid codes from
/// an element's standard code list, providing flexibility to accommodate
/// trading partner-specific requirements or industry variations. You can
/// specify codes to add to expand the allowed values beyond the X12 standard,
/// or codes to remove to restrict the allowed values for stricter validation.
pub const X12CodeListValidationRule = struct {
    /// Specifies a list of code values to add to the element's allowed values.
    /// These codes will be considered valid for the specified element in addition
    /// to the standard codes defined by the X12 specification.
    codes_to_add: ?[]const []const u8 = null,

    /// Specifies a list of code values to remove from the element's allowed values.
    /// These codes will be considered invalid for the specified element, even if
    /// they are part of the standard codes defined by the X12 specification.
    codes_to_remove: ?[]const []const u8 = null,

    /// Specifies the four-digit element ID to which the code list modifications
    /// apply. This identifies which X12 element will have its allowed code values
    /// modified.
    element_id: []const u8,

    pub const json_field_names = .{
        .codes_to_add = "codesToAdd",
        .codes_to_remove = "codesToRemove",
        .element_id = "elementId",
    };
};
