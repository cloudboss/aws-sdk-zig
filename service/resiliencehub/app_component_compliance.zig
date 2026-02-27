const aws = @import("aws");

const DisruptionCompliance = @import("disruption_compliance.zig").DisruptionCompliance;
const Cost = @import("cost.zig").Cost;
const ResiliencyScore = @import("resiliency_score.zig").ResiliencyScore;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Defines the compliance of an Application Component against the resiliency
/// policy.
pub const AppComponentCompliance = struct {
    /// Name of the Application Component.
    app_component_name: ?[]const u8,

    /// The compliance of the Application Component against the resiliency policy.
    compliance: ?[]const aws.map.MapEntry(DisruptionCompliance),

    /// The cost for the application.
    cost: ?Cost,

    /// The compliance message.
    message: ?[]const u8,

    /// The current resiliency score for the application.
    resiliency_score: ?ResiliencyScore,

    /// Status of the action.
    status: ?ComplianceStatus,

    pub const json_field_names = .{
        .app_component_name = "appComponentName",
        .compliance = "compliance",
        .cost = "cost",
        .message = "message",
        .resiliency_score = "resiliencyScore",
        .status = "status",
    };
};
