const aws = @import("aws");

const WorkloadImprovementStatus = @import("workload_improvement_status.zig").WorkloadImprovementStatus;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A workload summary return object.
pub const WorkloadSummary = struct {
    improvement_status: ?WorkloadImprovementStatus = null,

    lenses: ?[]const []const u8 = null,

    owner: ?[]const u8 = null,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// Profile associated with a workload.
    profiles: ?[]const WorkloadProfile = null,

    risk_counts: ?[]const aws.map.MapEntry(i32) = null,

    updated_at: ?i64 = null,

    workload_arn: ?[]const u8 = null,

    workload_id: ?[]const u8 = null,

    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .improvement_status = "ImprovementStatus",
        .lenses = "Lenses",
        .owner = "Owner",
        .prioritized_risk_counts = "PrioritizedRiskCounts",
        .profiles = "Profiles",
        .risk_counts = "RiskCounts",
        .updated_at = "UpdatedAt",
        .workload_arn = "WorkloadArn",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};
