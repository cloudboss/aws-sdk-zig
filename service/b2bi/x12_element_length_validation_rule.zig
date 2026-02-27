/// Defines a validation rule that specifies custom length constraints for a
/// specific X12 element. This rule allows you to override the standard minimum
/// and maximum length requirements for an element, enabling validation of
/// trading partner-specific length requirements that may differ from the X12
/// specification. Both minimum and maximum length values must be specified and
/// must be between 1 and 200 characters.
pub const X12ElementLengthValidationRule = struct {
    /// Specifies the four-digit element ID to which the length constraints will be
    /// applied. This identifies which X12 element will have its length requirements
    /// modified.
    element_id: []const u8,

    /// Specifies the maximum allowed length for the identified element. This value
    /// must be between 1 and 200 characters and defines the upper limit for the
    /// element's content length.
    max_length: i32,

    /// Specifies the minimum required length for the identified element. This value
    /// must be between 1 and 200 characters and defines the lower limit for the
    /// element's content length.
    min_length: i32,

    pub const json_field_names = .{
        .element_id = "elementId",
        .max_length = "maxLength",
        .min_length = "minLength",
    };
};
