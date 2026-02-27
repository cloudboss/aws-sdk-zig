const PropertyValidationExceptionReason = @import("property_validation_exception_reason.zig").PropertyValidationExceptionReason;

/// Contains information about why a property is not valid.
pub const PropertyValidationExceptionProperty = struct {
    /// A message describing why the property is not valid.
    message: []const u8,

    /// The full property path.
    property_path: []const u8,

    /// Why the property is not valid.
    reason: PropertyValidationExceptionReason,

    pub const json_field_names = .{
        .message = "Message",
        .property_path = "PropertyPath",
        .reason = "Reason",
    };
};
