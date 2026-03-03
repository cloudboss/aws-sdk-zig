const UnsuccessfulInstanceCreditSpecificationItemError = @import("unsuccessful_instance_credit_specification_item_error.zig").UnsuccessfulInstanceCreditSpecificationItemError;

/// Describes the burstable performance instance whose credit option for CPU
/// usage was not
/// modified.
pub const UnsuccessfulInstanceCreditSpecificationItem = struct {
    /// The applicable error for the burstable performance instance whose credit
    /// option for
    /// CPU usage was not modified.
    @"error": ?UnsuccessfulInstanceCreditSpecificationItemError = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,
};
