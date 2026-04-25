const PaymentRequestStatus = @import("payment_request_status.zig").PaymentRequestStatus;

/// Summary view of a payment request.
pub const PaymentRequestSummary = struct {
    /// The unique identifier of the agreement associated with this payment request.
    agreement_id: ?[]const u8 = null,

    /// The amount charged or to be charged to the buyer.
    charge_amount: ?[]const u8 = null,

    /// The unique identifier of the charge created after the payment request is
    /// approved. This field is only present for approved payment requests.
    charge_id: ?[]const u8 = null,

    /// The date and time when the payment request was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The currency code for the charge amount.
    currency_code: ?[]const u8 = null,

    /// The descriptive name of the payment request.
    name: ?[]const u8 = null,

    /// The unique identifier of the payment request.
    payment_request_id: ?[]const u8 = null,

    /// The current status of the payment request. Possible values include
    /// `VALIDATING`, `VALIDATION_FAILED`, `PENDING_APPROVAL`, `APPROVED`,
    /// `REJECTED`, and `CANCELLED`.
    status: ?PaymentRequestStatus = null,

    /// The date and time when the payment request was last updated, in ISO 8601
    /// format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .charge_amount = "chargeAmount",
        .charge_id = "chargeId",
        .created_at = "createdAt",
        .currency_code = "currencyCode",
        .name = "name",
        .payment_request_id = "paymentRequestId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
