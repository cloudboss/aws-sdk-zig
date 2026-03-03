const ContextAttribute = @import("context_attribute.zig").ContextAttribute;
const IssueDetails = @import("issue_details.zig").IssueDetails;
const RecommendedActionParameter = @import("recommended_action_parameter.zig").RecommendedActionParameter;

/// The recommended actions to apply to resolve the issues associated with your
/// DB instances, DB clusters, and DB parameter groups.
pub const RecommendedAction = struct {
    /// The unique identifier of the recommended action.
    action_id: ?[]const u8 = null,

    /// The methods to apply the recommended action.
    ///
    /// Valid values:
    ///
    /// * `manual` - The action requires you to resolve the recommendation manually.
    /// * `immediately` - The action is applied immediately.
    /// * `next-maintainance-window` - The action is applied during the next
    ///   scheduled maintainance.
    apply_modes: ?[]const []const u8 = null,

    /// The supporting attributes to explain the recommended action.
    context_attributes: ?[]const ContextAttribute = null,

    /// A detailed description of the action. The description might contain
    /// markdown.
    description: ?[]const u8 = null,

    /// The details of the issue.
    issue_details: ?IssueDetails = null,

    /// An API operation for the action.
    operation: ?[]const u8 = null,

    /// The parameters for the API operation.
    parameters: ?[]const RecommendedActionParameter = null,

    /// The status of the action.
    ///
    /// * `ready`
    /// * `applied`
    /// * `scheduled`
    /// * `resolved`
    status: ?[]const u8 = null,

    /// A short description to summarize the action. The description might contain
    /// markdown.
    title: ?[]const u8 = null,
};
