const CurrentInstance = @import("current_instance.zig").CurrentInstance;
const FindingReasonCode = @import("finding_reason_code.zig").FindingReasonCode;
const ModifyRecommendationDetail = @import("modify_recommendation_detail.zig").ModifyRecommendationDetail;
const RightsizingType = @import("rightsizing_type.zig").RightsizingType;
const TerminateRecommendationDetail = @import("terminate_recommendation_detail.zig").TerminateRecommendationDetail;

/// Recommendations to rightsize resources.
pub const RightsizingRecommendation = struct {
    /// The account that this recommendation is for.
    account_id: ?[]const u8 = null,

    /// Context
    /// regarding the current instance.
    current_instance: ?CurrentInstance = null,

    /// The list of possible reasons why the recommendation is generated, such as
    /// under- or
    /// over-utilization of specific metrics (for example, CPU, Memory, Network).
    finding_reason_codes: ?[]const FindingReasonCode = null,

    /// The details for the modification recommendations.
    modify_recommendation_detail: ?ModifyRecommendationDetail = null,

    /// A recommendation to either terminate or modify the resource.
    rightsizing_type: ?RightsizingType = null,

    /// The details for termination recommendations.
    terminate_recommendation_detail: ?TerminateRecommendationDetail = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .current_instance = "CurrentInstance",
        .finding_reason_codes = "FindingReasonCodes",
        .modify_recommendation_detail = "ModifyRecommendationDetail",
        .rightsizing_type = "RightsizingType",
        .terminate_recommendation_detail = "TerminateRecommendationDetail",
    };
};
