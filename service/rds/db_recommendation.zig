const IssueDetails = @import("issue_details.zig").IssueDetails;
const DocLink = @import("doc_link.zig").DocLink;
const RecommendedAction = @import("recommended_action.zig").RecommendedAction;

/// The recommendation for your DB instances, DB clusters, and DB parameter
/// groups.
pub const DBRecommendation = struct {
    /// Additional information about the recommendation. The information might
    /// contain markdown.
    additional_info: ?[]const u8 = null,

    /// The category of the recommendation.
    ///
    /// Valid values:
    ///
    /// * `performance efficiency`
    /// * `security`
    /// * `reliability`
    /// * `cost optimization`
    /// * `operational excellence`
    /// * `sustainability`
    category: ?[]const u8 = null,

    /// The time when the recommendation was created. For example,
    /// `2023-09-28T01:13:53.931000+00:00`.
    created_time: ?i64 = null,

    /// A detailed description of the recommendation. The description might contain
    /// markdown.
    description: ?[]const u8 = null,

    /// A short description of the issue identified for this recommendation. The
    /// description might contain markdown.
    detection: ?[]const u8 = null,

    /// A short description that explains the possible impact of an issue.
    impact: ?[]const u8 = null,

    /// Details of the issue that caused the recommendation.
    issue_details: ?IssueDetails = null,

    /// A link to documentation that provides additional information about the
    /// recommendation.
    links: ?[]const DocLink = null,

    /// The reason why this recommendation was created. The information might
    /// contain markdown.
    reason: ?[]const u8 = null,

    /// A short description of the recommendation to resolve an issue. The
    /// description might contain markdown.
    recommendation: ?[]const u8 = null,

    /// The unique identifier of the recommendation.
    recommendation_id: ?[]const u8 = null,

    /// A list of recommended actions.
    recommended_actions: ?[]const RecommendedAction = null,

    /// The Amazon Resource Name (ARN) of the RDS resource associated with the
    /// recommendation.
    resource_arn: ?[]const u8 = null,

    /// The severity level of the recommendation. The severity level can help you
    /// decide the urgency with which to address the recommendation.
    ///
    /// Valid values:
    ///
    /// * `high`
    /// * `medium`
    /// * `low`
    /// * `informational`
    severity: ?[]const u8 = null,

    /// The Amazon Web Services service that generated the recommendations.
    source: ?[]const u8 = null,

    /// The current status of the recommendation.
    ///
    /// Valid values:
    ///
    /// * `active` - The recommendations which are ready for you to apply.
    /// * `pending` - The applied or scheduled recommendations which are in
    ///   progress.
    /// * `resolved` - The recommendations which are completed.
    /// * `dismissed` - The recommendations that you dismissed.
    status: ?[]const u8 = null,

    /// A short description of the recommendation type. The description might
    /// contain markdown.
    type_detection: ?[]const u8 = null,

    /// A value that indicates the type of recommendation. This value determines how
    /// the description is rendered.
    type_id: ?[]const u8 = null,

    /// A short description that summarizes the recommendation to fix all the issues
    /// of the recommendation type. The description might contain markdown.
    type_recommendation: ?[]const u8 = null,

    /// The time when the recommendation was last updated.
    updated_time: ?i64 = null,
};
