const aws = @import("aws");

const WorkloadImprovementStatus = @import("workload_improvement_status.zig").WorkloadImprovementStatus;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A workload summary return object.
pub const WorkloadSummary = struct {
    improvement_status: ?WorkloadImprovementStatus,

    lenses: ?[]const []const u8,

    owner: ?[]const u8,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32),

    /// Profile associated with a workload.
    profiles: ?[]const WorkloadProfile,

    risk_counts: ?[]const aws.map.MapEntry(i32),

    updated_at: ?i64,

    workload_arn: ?[]const u8,

    workload_id: ?[]const u8,

    workload_name: ?[]const u8,

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
