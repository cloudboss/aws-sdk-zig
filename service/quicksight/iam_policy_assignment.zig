const aws = @import("aws");

const AssignmentStatus = @import("assignment_status.zig").AssignmentStatus;

/// An Identity and Access Management (IAM) policy assignment.
pub const IAMPolicyAssignment = struct {
    /// Assignment ID.
    assignment_id: ?[]const u8,

    /// Assignment name.
    assignment_name: ?[]const u8,

    /// Assignment status.
    assignment_status: ?AssignmentStatus,

    /// The Amazon Web Services account ID.
    aws_account_id: ?[]const u8,

    /// Identities.
    identities: ?[]const aws.map.MapEntry([]const []const u8),

    /// The Amazon Resource Name (ARN) for the IAM policy.
    policy_arn: ?[]const u8,

    pub const json_field_names = .{
        .assignment_id = "AssignmentId",
        .assignment_name = "AssignmentName",
        .assignment_status = "AssignmentStatus",
        .aws_account_id = "AwsAccountId",
        .identities = "Identities",
        .policy_arn = "PolicyArn",
    };
};
