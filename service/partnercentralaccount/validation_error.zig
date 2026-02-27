const BusinessValidationError = @import("business_validation_error.zig").BusinessValidationError;
const FieldValidationError = @import("field_validation_error.zig").FieldValidationError;

/// Contains information about a validation error, which can be either a
/// field-level or business rule validation error.
pub const ValidationError = union(enum) {
    /// Details about a business rule validation error, if applicable.
    business_validation_error: ?BusinessValidationError,
    /// Details about a field-level validation error, if applicable.
    field_validation_error: ?FieldValidationError,

    pub const json_field_names = .{
        .business_validation_error = "BusinessValidationError",
        .field_validation_error = "FieldValidationError",
    };
};
