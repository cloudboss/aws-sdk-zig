const aws = @import("aws");

const LensStatus = @import("lens_status.zig").LensStatus;
const WorkloadProfile = @import("workload_profile.zig").WorkloadProfile;

/// A lens review summary of a workload.
pub const LensReviewSummary = struct {
    lens_alias: ?[]const u8,

    /// The ARN for the lens.
    lens_arn: ?[]const u8,

    lens_name: ?[]const u8,

    /// The status of the lens.
    lens_status: ?LensStatus,

    /// The version of the lens.
    lens_version: ?[]const u8,

    prioritized_risk_counts: ?[]const aws.map.MapEntry(i32),

    /// The profiles associated with the workload.
    profiles: ?[]const WorkloadProfile,

    risk_counts: ?[]const aws.map.MapEntry(i32),

    updated_at: ?i64,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .lens_name = "LensName",
        .lens_status = "LensStatus",
        .lens_version = "LensVersion",
        .prioritized_risk_counts = "PrioritizedRiskCounts",
        .profiles = "Profiles",
        .risk_counts = "RiskCounts",
        .updated_at = "UpdatedAt",
    };
};
