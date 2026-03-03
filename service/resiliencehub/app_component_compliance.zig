const aws = @import("aws");

const DisruptionCompliance = @import("disruption_compliance.zig").DisruptionCompliance;
const Cost = @import("cost.zig").Cost;
const ResiliencyScore = @import("resiliency_score.zig").ResiliencyScore;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Defines the compliance of an Application Component against the resiliency
/// policy.
pub const AppComponentCompliance = struct {
    /// Name of the Application Component.
    app_component_name: ?[]const u8 = null,

    /// The compliance of the Application Component against the resiliency policy.
    compliance: ?[]const aws.map.MapEntry(DisruptionCompliance) = null,

    /// The cost for the application.
    cost: ?Cost = null,

    /// The compliance message.
    message: ?[]const u8 = null,

    /// The current resiliency score for the application.
    resiliency_score: ?ResiliencyScore = null,

    /// Status of the action.
    status: ?ComplianceStatus = null,

    pub const json_field_names = .{
        .app_component_name = "appComponentName",
        .compliance = "compliance",
        .cost = "cost",
        .message = "message",
        .resiliency_score = "resiliencyScore",
        .status = "status",
    };
};
