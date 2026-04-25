const AgreementCancellationRequestReasonCode = @import("agreement_cancellation_request_reason_code.zig").AgreementCancellationRequestReasonCode;
const AgreementCancellationRequestStatus = @import("agreement_cancellation_request_status.zig").AgreementCancellationRequestStatus;

/// Summary view of an agreement cancellation request.
pub const AgreementCancellationRequestSummary = struct {
    /// The unique identifier of the cancellation request.
    agreement_cancellation_request_id: ?[]const u8 = null,

    /// The unique identifier of the agreement associated with this cancellation
    /// request.
    agreement_id: ?[]const u8 = null,

    /// The type of agreement.
    agreement_type: ?[]const u8 = null,

    /// The catalog in which the agreement was created.
    catalog: ?[]const u8 = null,

    /// The date and time when the cancellation request was created, as a POSIX
    /// timestamp (Unix epoch seconds).
    created_at: ?i64 = null,

    /// The reason code provided for the cancellation.
    reason_code: ?AgreementCancellationRequestReasonCode = null,

    /// The current status of the cancellation request. Possible values include
    /// `PENDING_APPROVAL`, `APPROVED`, `REJECTED`, `CANCELLED`, and
    /// `VALIDATION_FAILED`.
    status: ?AgreementCancellationRequestStatus = null,

    /// The date and time when the cancellation request was last updated, as a POSIX
    /// timestamp (Unix epoch seconds).
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agreement_cancellation_request_id = "agreementCancellationRequestId",
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .catalog = "catalog",
        .created_at = "createdAt",
        .reason_code = "reasonCode",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
