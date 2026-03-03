const Acceptor = @import("acceptor.zig").Acceptor;
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

    /// The type of agreement. Value is `PurchaseAgreement`.
    agreement_type: ?[]const u8 = null,

    /// The date and time when the agreement ends. The field is `null` for
    /// pay-as-you-go agreements, which don’t have end dates.
    end_time: ?i64 = null,

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
        .proposal_summary = "proposalSummary",
        .proposer = "proposer",
        .start_time = "startTime",
        .status = "status",
    };
};
