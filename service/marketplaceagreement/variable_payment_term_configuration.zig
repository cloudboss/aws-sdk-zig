const PaymentRequestApprovalStrategy = @import("payment_request_approval_strategy.zig").PaymentRequestApprovalStrategy;

/// Additional parameters specified by the acceptor while accepting the variable
/// payment term.
pub const VariablePaymentTermConfiguration = struct {
    /// Defines the duration after which a payment request is automatically approved
    /// if no further action is taken. This only applies when the payment request
    /// approval strategy is set to `AUTO_APPROVE_ON_EXPIRATION`. The duration is
    /// represented in the ISO_8601 format (e.g., P10D for 10 days).
    expiration_duration: ?[]const u8 = null,

    /// Defines the strategy for approving payment requests. Values include
    /// `AUTO_APPROVE_ON_EXPIRATION` and `WAIT_FOR_APPROVAL`
    payment_request_approval_strategy: PaymentRequestApprovalStrategy,

    pub const json_field_names = .{
        .expiration_duration = "expirationDuration",
        .payment_request_approval_strategy = "paymentRequestApprovalStrategy",
    };
};
