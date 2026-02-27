const BusinessValidationCode = @import("business_validation_code.zig").BusinessValidationCode;

/// Contains information about a business rule validation error that occurred
/// during an operation.
pub const BusinessValidationError = struct {
    /// A code identifying the specific business validation error.
    code: BusinessValidationCode,

    /// A description of the business validation error.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
