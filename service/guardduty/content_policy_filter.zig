const ContentPolicyFilterAction = @import("content_policy_filter_action.zig").ContentPolicyFilterAction;
const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;
const ContentPolicyFilterType = @import("content_policy_filter_type.zig").ContentPolicyFilterType;

/// Contains information about a content policy filter that matched during a
/// guardrail evaluation.
pub const ContentPolicyFilter = struct {
    /// The action taken by the guardrail filter.
    action: ?ContentPolicyFilterAction = null,

    /// The confidence level that the content matched the filter.
    confidence: ?ConfidenceLevel = null,

    /// The type of content that was filtered by the guardrail.
    type: ?ContentPolicyFilterType = null,

    pub const json_field_names = .{
        .action = "Action",
        .confidence = "Confidence",
        .type = "Type",
    };
};
