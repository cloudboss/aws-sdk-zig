const FargateProfileIssue = @import("fargate_profile_issue.zig").FargateProfileIssue;

/// The health status of the Fargate profile. If there are issues with your
/// Fargate
/// profile's health, they are listed here.
pub const FargateProfileHealth = struct {
    /// Any issues that are associated with the Fargate profile.
    issues: ?[]const FargateProfileIssue,

    pub const json_field_names = .{
        .issues = "issues",
    };
};
