const Acceptor = @import("acceptor.zig").Acceptor;
const EndTimeBehaviorReasonCode = @import("end_time_behavior_reason_code.zig").EndTimeBehaviorReasonCode;
const EndTimeBehaviorType = @import("end_time_behavior_type.zig").EndTimeBehaviorType;
const Entitlement = @import("entitlement.zig").Entitlement;
const ProposalSummary = @import("proposal_summary.zig").ProposalSummary;
const Proposer = @import("proposer.zig").Proposer;
const AgreementStatus = @import("agreement_status.zig").AgreementStatus;

/// A summary of the agreement, including top-level attributes (for example, the
/// agreement ID, proposer, and acceptor).
pub const AgreementViewSummary = struct {
    /// The date and time that the agreement was accepted.
    acceptance_time: ?i64 = null,

    /// Details of the party accepting the agreement terms. This is commonly the
    /// buyer for `PurchaseAgreement.`
    acceptor: ?Acceptor = null,

    /// The unique identifier of the agreement.
    agreement_id: ?[]const u8 = null,

    /// The type of agreement.
    agreement_type: ?[]const u8 = null,

    /// The date and time when the agreement ends. The field is `null` for
    /// pay-as-you-go agreements, which don’t have end dates.
    end_time: ?i64 = null,

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
    end_time_behavior_reason_code: ?EndTimeBehaviorReasonCode = null,

    /// The behavior of the agreement when it reaches its end date. The field is
    /// `null` for agreements that have no end date, because those agreements never
    /// reach an end time.
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
    end_time_behavior_type: ?EndTimeBehaviorType = null,

    /// A list of entitlements associated with the agreement.
    entitlements: ?[]const Entitlement = null,

    /// The unique identifier of the very first agreement in a chain of related
    /// agreements, such as renewals or replacements. It stays the same across all
    /// agreements in that chain, which lets you trace an agreement back to the
    /// original. You can also use it as the `InitialAgreementId` filter value to
    /// return every agreement in the same chain.
    initial_agreement_id: ?[]const u8 = null,

    /// The date and time when the agreement was last updated. An agreement is
    /// updated when any of its attributes or accepted terms change. Amendments,
    /// renewals, and a party changing whether the agreement renews are all
    /// examples.
    ///
    /// Use the `BeforeLastUpdateTime` and `AfterLastUpdateTime` filters to search
    /// on this value, and `LastUpdateTime` as the `SortBy` value to sort by it.
    /// Sorting by `LastUpdateTime` is supported only when `PartyType` is
    /// `Proposer`.
    last_update_time: ?i64 = null,

    /// A summary of the proposal
    proposal_summary: ?ProposalSummary = null,

    /// Details of the party proposing the agreement terms, most commonly the seller
    /// for `PurchaseAgreement`.
    proposer: ?Proposer = null,

    /// The date and time when the agreement starts.
    start_time: ?i64 = null,

    /// The current status of the agreement.
    status: ?AgreementStatus = null,

    pub const json_field_names = .{
        .acceptance_time = "acceptanceTime",
        .acceptor = "acceptor",
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .end_time = "endTime",
        .end_time_behavior_reason_code = "endTimeBehaviorReasonCode",
        .end_time_behavior_type = "endTimeBehaviorType",
        .entitlements = "entitlements",
        .initial_agreement_id = "initialAgreementId",
        .last_update_time = "lastUpdateTime",
        .proposal_summary = "proposalSummary",
        .proposer = "proposer",
        .start_time = "startTime",
        .status = "status",
    };
};
