const UnsuccessfulInstanceCreditSpecificationErrorCode = @import("unsuccessful_instance_credit_specification_error_code.zig").UnsuccessfulInstanceCreditSpecificationErrorCode;

/// Information about the error for the burstable performance instance whose
/// credit option
/// for CPU usage was not modified.
pub const UnsuccessfulInstanceCreditSpecificationItemError = struct {
    /// The error code.
    code: ?UnsuccessfulInstanceCreditSpecificationErrorCode = null,

    /// The applicable error message.
    message: ?[]const u8 = null,
};
