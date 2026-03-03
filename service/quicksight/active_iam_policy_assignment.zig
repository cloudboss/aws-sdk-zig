/// The active Identity and Access Management (IAM) policy assignment.
pub const ActiveIAMPolicyAssignment = struct {
    /// A name for the IAM policy assignment.
    assignment_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource.
    policy_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .assignment_name = "AssignmentName",
        .policy_arn = "PolicyArn",
    };
};
