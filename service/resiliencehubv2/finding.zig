const FailureCategory = @import("failure_category.zig").FailureCategory;
const InfrastructureAndCodeRecommendation = @import("infrastructure_and_code_recommendation.zig").InfrastructureAndCodeRecommendation;
const ObservabilityRecommendation = @import("observability_recommendation.zig").ObservabilityRecommendation;
const PolicyComponent = @import("policy_component.zig").PolicyComponent;
const FindingSeverity = @import("finding_severity.zig").FindingSeverity;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const TestingRecommendation = @import("testing_recommendation.zig").TestingRecommendation;

/// Represents a resilience finding from a failure mode assessment.
pub const Finding = struct {
    /// A user-provided comment about the finding.
    comment: ?[]const u8 = null,

    description: ?[]const u8 = null,

    /// The failure category of the finding.
    failure_category: ?FailureCategory = null,

    /// The unique identifier of the finding.
    finding_id: ?[]const u8 = null,

    /// Infrastructure and code recommendations to address the finding.
    infrastructure_and_code_recommendations: ?[]const InfrastructureAndCodeRecommendation = null,

    /// The name of the finding.
    name: ?[]const u8 = null,

    /// Observability recommendations to address the finding.
    observability_recommendations: ?[]const ObservabilityRecommendation = null,

    /// The policy component associated with the finding.
    policy_component: ?PolicyComponent = null,

    /// The reasoning behind the finding.
    reasoning: ?[]const u8 = null,

    /// The service functions associated with the finding.
    service_functions: ?[]const []const u8 = null,

    /// The severity of the finding.
    severity: ?FindingSeverity = null,

    /// The current status of the finding.
    status: ?FindingStatus = null,

    /// Testing recommendations to address the finding.
    testing_recommendations: ?[]const TestingRecommendation = null,

    /// The timestamp when the finding was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .comment = "comment",
        .description = "description",
        .failure_category = "failureCategory",
        .finding_id = "findingId",
        .infrastructure_and_code_recommendations = "infrastructureAndCodeRecommendations",
        .name = "name",
        .observability_recommendations = "observabilityRecommendations",
        .policy_component = "policyComponent",
        .reasoning = "reasoning",
        .service_functions = "serviceFunctions",
        .severity = "severity",
        .status = "status",
        .testing_recommendations = "testingRecommendations",
        .updated_at = "updatedAt",
    };
};
