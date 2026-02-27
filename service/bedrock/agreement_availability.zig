const AgreementStatus = @import("agreement_status.zig").AgreementStatus;

/// Information about the agreement availability
pub const AgreementAvailability = struct {
    /// Error message.
    error_message: ?[]const u8,

    /// Status of the agreement.
    status: AgreementStatus,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .status = "status",
    };
};
