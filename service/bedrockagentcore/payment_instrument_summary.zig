const PaymentInstrumentType = @import("payment_instrument_type.zig").PaymentInstrumentType;
const PaymentInstrumentStatus = @import("payment_instrument_status.zig").PaymentInstrumentStatus;

/// Summary of a payment instrument for list operations
pub const PaymentInstrumentSummary = struct {
    /// The timestamp when this payment instrument was created.
    created_at: i64,

    /// The ID of the payment connector associated with this instrument.
    payment_connector_id: []const u8,

    /// The unique identifier for this payment instrument.
    payment_instrument_id: []const u8,

    /// The type of payment instrument (e.g., EMBEDDED_CRYPTO_WALLET).
    payment_instrument_type: PaymentInstrumentType,

    /// The ARN of the payment manager that owns this payment instrument.
    payment_manager_arn: []const u8,

    /// The current status of this payment instrument.
    status: PaymentInstrumentStatus,

    /// The timestamp when this payment instrument was last updated.
    updated_at: i64,

    /// The user ID associated with this payment instrument.
    user_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .payment_connector_id = "paymentConnectorId",
        .payment_instrument_id = "paymentInstrumentId",
        .payment_instrument_type = "paymentInstrumentType",
        .payment_manager_arn = "paymentManagerArn",
        .status = "status",
        .updated_at = "updatedAt",
        .user_id = "userId",
    };
};
