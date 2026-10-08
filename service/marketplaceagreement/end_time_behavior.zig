const EndTimeBehaviorReasonCode = @import("end_time_behavior_reason_code.zig").EndTimeBehaviorReasonCode;
const RenewalSummary = @import("renewal_summary.zig").RenewalSummary;
const EndTimeBehaviorType = @import("end_time_behavior_type.zig").EndTimeBehaviorType;

/// The behavior of an agreement when it reaches its end date. For example,
/// whether the agreement renews, and if it doesn't, the reason why.
pub const EndTimeBehavior = struct {
    /// The reason why the agreement doesn't renew at its end date. The field is
    /// `null` when the agreement renews.
    ///
    /// More than one reason can apply to the same agreement. When that happens, the
    /// operation returns only one reason code, and `PROPOSER_RENEW_OPTED_OUT` takes
    /// precedence over all others.
    ///
    /// The `EnableAutoRenew` field reflects only the acceptor's preference, and
    /// doesn't reflect the other reasons an agreement might not renew.
    ///
    /// Reason codes include:
    ///
    /// * `PROPOSER_RENEW_OPTED_OUT` – The proposer opted out of renewing the
    ///   agreement.
    /// * `ACCEPTOR_RENEW_OPTED_OUT` – The acceptor opted out of renewing the
    ///   agreement.
    /// * `NO_RENEWAL_TERM` – The accepted terms of the agreement don't include a
    ///   renewal term, which is required for an agreement to renew.
    /// * `RENEWAL_LIMIT_EXHAUSTED` – The agreement reached the maximum number of
    ///   renewals allowed by its renewal term.
    reason_code: ?EndTimeBehaviorReasonCode = null,

    /// The details of the renewal that applies at the end date of the agreement.
    /// This field is present when `Type` is `RENEW`. It is also present when
    /// `ReasonCode` is `PROPOSER_RENEW_OPTED_OUT` or `ACCEPTOR_RENEW_OPTED_OUT`. In
    /// those cases, it identifies the offer that the agreement would otherwise have
    /// renewed from. The field is `null` in all other cases.
    renewal_summary: ?RenewalSummary = null,

    /// The behavior of the agreement when it reaches its end date.
    ///
    /// Types include:
    ///
    /// * `RENEW` – A new agreement is created from the accepted terms of this
    ///   agreement.
    /// * `REPLACE` – A new agreement is created from a different offer than the one
    ///   this agreement was created from. This happens, for example, when a private
    ///   offer reaches its end date and the acceptor transitions to the public
    ///   offer for the product.
    /// * `EXPIRE` – The agreement ends and isn't renewed or replaced.
    type: EndTimeBehaviorType,

    pub const json_field_names = .{
        .reason_code = "reasonCode",
        .renewal_summary = "renewalSummary",
        .type = "type",
    };
};
