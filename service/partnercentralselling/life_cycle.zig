const ClosedLostReason = @import("closed_lost_reason.zig").ClosedLostReason;
const NextStepsHistory = @import("next_steps_history.zig").NextStepsHistory;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const Stage = @import("stage.zig").Stage;

/// An object that contains the `Opportunity` lifecycle's details.
pub const LifeCycle = struct {
    /// Specifies the reason code when an opportunity is marked as *Closed Lost*.
    /// When you select an appropriate reason code, you communicate the context for
    /// closing the `Opportunity`, and aid in accurate reports and analysis of
    /// opportunity outcomes. The possible values are:
    ///
    /// * Customer Deficiency: The customer lacked necessary resources or
    ///   capabilities.
    /// * Delay/Cancellation of Project: The project was delayed or canceled.
    /// * Legal/Tax/Regulatory: Legal, tax, or regulatory issues prevented progress.
    /// * Lost to Competitor—Google: The opportunity was lost to Google.
    /// * Lost to Competitor—Microsoft: The opportunity was lost to Microsoft.
    /// * Lost to Competitor—SoftLayer: The opportunity was lost to SoftLayer.
    /// * Lost to Competitor—VMWare: The opportunity was lost to VMWare.
    /// * Lost to Competitor—Other: The opportunity was lost to a competitor not
    ///   listed above.
    /// * No Opportunity: There was no opportunity to pursue.
    /// * On Premises Deployment: The customer chose an on-premises solution.
    /// * Partner Gap: The partner lacked necessary resources or capabilities.
    /// * Price: The price was not competitive or acceptable to the customer.
    /// * Security/Compliance: Security or compliance issues prevented progress.
    /// * Technical Limitations: Technical limitations prevented progress.
    /// * Customer Experience: Issues related to the customer's experience impacted
    ///   the decision.
    /// * Other: Any reason not covered by the other values.
    /// * People/Relationship/Governance: Issues related to people, relationships,
    ///   or governance.
    /// * Product/Technology: Issues related to the product or technology.
    /// * Financial/Commercial: Financial or commercial issues impacted the
    ///   decision.
    closed_lost_reason: ?ClosedLostReason,

    /// Specifies the upcoming actions or tasks for the `Opportunity`. Use this
    /// field to communicate with Amazon Web Services about the next actions
    /// required for the `Opportunity`.
    next_steps: ?[]const u8,

    /// Captures a chronological record of the next steps or actions planned or
    /// taken for the current opportunity, along with the timestamp.
    next_steps_history: ?[]const NextStepsHistory,

    /// Contains detailed feedback from Amazon Web Services when requesting
    /// additional information from partners. Provides specific guidance on what
    /// partners need to provide or clarify for opportunity validation,
    /// complementing the `ReviewStatusReason` field.
    review_comments: ?[]const u8,

    /// Indicates the review status of an opportunity referred by a partner. This
    /// field is read-only and only applicable for partner referrals. The possible
    /// values are:
    ///
    /// * Pending Submission: Not submitted for validation (editable).
    /// * Submitted: Submitted for validation, and Amazon Web Services hasn't
    ///   reviewed it (read-only).
    /// * In Review: Amazon Web Services is validating (read-only).
    /// * Action Required: Issues that Amazon Web Services highlights need to be
    ///   addressed. Partners should use the `UpdateOpportunity` API action to
    ///   update the opportunity and helps to ensure that all required changes are
    ///   made. Only the following fields are editable when the
    ///   `Lifecycle.ReviewStatus` is `Action Required`:
    ///
    /// * Customer.Account.Address.City
    /// * Customer.Account.Address.CountryCode
    /// * Customer.Account.Address.PostalCode
    /// * Customer.Account.Address.StateOrRegion
    /// * Customer.Account.Address.StreetAddress
    /// * Customer.Account.WebsiteUrl
    /// * LifeCycle.TargetCloseDate
    /// * Project.ExpectedMonthlyAWSRevenue.Amount
    /// * Project.ExpectedMonthlyAWSRevenue.CurrencyCode
    /// * Project.CustomerBusinessProblem
    /// * PartnerOpportunityIdentifier
    ///
    /// After updates, the opportunity re-enters the validation phase. This process
    /// repeats until all issues are resolved, and the opportunity's
    /// `Lifecycle.ReviewStatus` is set to `Approved` or `Rejected`.
    /// * Approved: Validated and converted into the Amazon Web Services seller's
    ///   pipeline (editable).
    /// * Rejected: Disqualified (read-only).
    review_status: ?ReviewStatus,

    /// Code indicating the validation decision during the Amazon Web Services
    /// opportunity review. Applies when status is `Rejected` or `Action Required`.
    /// Used to document validation results for AWS Partner Referrals and indicate
    /// when additional information is needed from partners as part of the APN
    /// Customer Engagement (ACE) program.
    review_status_reason: ?[]const u8,

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
    ///   viability and requirements. The customer agreed that the opportunity is
    ///   real, of interest, and may solve business/technical needs.
    /// * Technical Validation: All parties understand the implementation plan.
    /// * Business Validation: Pricing was proposed, and all parties agree to the
    ///   steps to close.
    /// * Committed: The customer signed the contract, but Amazon Web Services
    ///   hasn't started billing.
    /// * Launched: The workload is complete, and Amazon Web Services has started
    ///   billing.
    /// * Closed Lost: The opportunity is lost, and there are no steps to move
    ///   forward.
    stage: ?Stage,

    /// Specifies the date when Amazon Web Services expects to start significant
    /// billing, when the project finishes, and when it moves into production. This
    /// field informs the Amazon Web Services seller about when the opportunity
    /// launches and starts to incur Amazon Web Services usage.
    ///
    /// Ensure the `Target Close Date` isn't in the past.
    target_close_date: ?[]const u8,

    pub const json_field_names = .{
        .closed_lost_reason = "ClosedLostReason",
        .next_steps = "NextSteps",
        .next_steps_history = "NextStepsHistory",
        .review_comments = "ReviewComments",
        .review_status = "ReviewStatus",
        .review_status_reason = "ReviewStatusReason",
        .stage = "Stage",
        .target_close_date = "TargetCloseDate",
    };
};
