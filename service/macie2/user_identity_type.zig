/// The type of entity that performed the action on the affected resource.
/// Possible values are:
pub const UserIdentityType = enum {
    assumed_role,
    iam_user,
    federated_user,
    root,
    aws_account,
    aws_service,

    pub const json_field_names = .{
        .assumed_role = "AssumedRole",
        .iam_user = "IAMUser",
        .federated_user = "FederatedUser",
        .root = "Root",
        .aws_account = "AWSAccount",
        .aws_service = "AWSService",
    };
};
