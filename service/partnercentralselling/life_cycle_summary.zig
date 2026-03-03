const ClosedLostReason = @import("closed_lost_reason.zig").ClosedLostReason;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const Stage = @import("stage.zig").Stage;

/// An object that contains a `LifeCycle` object's subset of fields.
pub const LifeCycleSummary = struct {
    /// Specifies the reason code when an opportunity is marked as *Closed Lost*.
    /// When you select an appropriate reason code, you communicate the context for
    /// closing the `Opportunity`, and aid in accurate reports and analysis of
    /// opportunity outcomes.
    closed_lost_reason: ?ClosedLostReason = null,

    /// Specifies the upcoming actions or tasks for the `Opportunity`. This field is
    /// utilized to communicate to Amazon Web Services the next actions required for
    /// the `Opportunity`.
    next_steps: ?[]const u8 = null,

    /// Indicates why an opportunity was sent back for further details. Partners
    /// must take corrective action based on the `ReviewComments`.
    review_comments: ?[]const u8 = null,

    /// Indicates the review status of a partner referred opportunity. This field is
    /// read-only and only applicable for partner referrals. Valid values:
    ///
    /// * Pending Submission: Not submitted for validation (editable).
    /// * Submitted: Submitted for validation and not yet Amazon Web Services
    ///   reviewed (read-only).
    /// * In Review: Undergoing Amazon Web Services validation (read-only).
    /// * Action Required: Address any issues Amazon Web Services highlights. Use
    ///   the `UpdateOpportunity` API action to update the opportunity, and ensure
    ///   you make all required changes. Only these fields are editable when the
    ///   `Lifecycle.ReviewStatus` is `Action Required`:
    ///
    /// * Customer.Account.Address.City
    /// * Customer.Account.Address.CountryCode
    /// * Customer.Account.Address.PostalCode
    /// * Customer.Account.Address.StateOrRegion
    /// * Customer.Account.Address.StreetAddress
    /// * Customer.Account.WebsiteUrl
    /// * LifeCycle.TargetCloseDate
    /// * Project.ExpectedCustomerSpend.Amount
    /// * Project.ExpectedCustomerSpend.CurrencyCode
    /// * Project.CustomerBusinessProblem
    /// * PartnerOpportunityIdentifier
    ///
    /// After updates, the opportunity re-enters the validation phase. This process
    /// repeats until all issues are resolved, and the opportunity's
    /// `Lifecycle.ReviewStatus` is set to `Approved` or `Rejected`.
    /// * Approved: Validated and converted into the Amazon Web Services seller's
    ///   pipeline (editable).
    /// * Rejected: Disqualified (read-only).
    review_status: ?ReviewStatus = null,

    /// Indicates the reason a specific decision was taken during the opportunity
    /// review process. This field combines the reasons for both disqualified and
    /// action required statuses, and provides clarity for why an opportunity was
    /// disqualified or required further action.
    review_status_reason: ?[]const u8 = null,

    /// Specifies the current stage of the `Opportunity`'s lifecycle as it maps to
    /// Amazon Web Services stages from the current stage in the partner CRM. This
    /// field provides a translated value of the stage, and offers insight into the
    /// `Opportunity`'s progression in the sales cycle, according to Amazon Web
    /// Services definitions.
    ///
    /// A lead and a prospect must be further matured to a `Qualified` opportunity
    /// before submission. Opportunities that were closed/lost before submission
    /// aren't suitable for submission.
    ///
    /// The descriptions of each sales stage are:
    ///
    /// * Prospect: Amazon Web Services identifies the opportunity. It can be active
    ///   (Comes directly from the end customer through a lead) or latent (Your
    ///   account team believes it exists based on research, account plans, sales
    ///   plays).
    /// * Qualified: Your account team engaged with the customer to discuss
    ///   viability and understand requirements. The customer agreed that the
    ///   opportunity is real, of interest, and may solve business/technical needs.
    /// * Technical Validation: All parties understand the implementation plan.
    /// * Business Validation: Pricing was proposed, and all parties agree to the
    ///   steps to close.
    /// * Committed: The customer signed the contract, but Amazon Web Services
    ///   hasn't started billing.
    /// * Launched: The workload is complete, and Amazon Web Services has started
    ///   billing.
    /// * Closed Lost: The opportunity is lost, and there are no steps to move
    ///   forward.
    stage: ?Stage = null,

    /// Specifies the date when Amazon Web Services expects to start significant
    /// billing, when the project finishes, and when it moves into production. This
    /// field informs the Amazon Web Services seller about when the opportunity
    /// launches and starts to incur Amazon Web Services usage.
    ///
    /// Ensure the `Target Close Date` isn't in the past.
    target_close_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .closed_lost_reason = "ClosedLostReason",
        .next_steps = "NextSteps",
        .review_comments = "ReviewComments",
        .review_status = "ReviewStatus",
        .review_status_reason = "ReviewStatusReason",
        .stage = "Stage",
        .target_close_date = "TargetCloseDate",
    };
};
