const AssumedRole = @import("assumed_role.zig").AssumedRole;
const AwsAccount = @import("aws_account.zig").AwsAccount;
const AwsService = @import("aws_service.zig").AwsService;
const FederatedUser = @import("federated_user.zig").FederatedUser;
const IamUser = @import("iam_user.zig").IamUser;
const UserIdentityRoot = @import("user_identity_root.zig").UserIdentityRoot;
const UserIdentityType = @import("user_identity_type.zig").UserIdentityType;

/// Provides information about the type and other characteristics of an entity
/// that performed an action on an affected resource.
pub const UserIdentity = struct {
    /// If the action was performed with temporary security credentials that were
    /// obtained using the AssumeRole operation of the Security Token Service (STS)
    /// API, the identifiers, session context, and other details about the identity.
    assumed_role: ?AssumedRole = null,

    /// If the action was performed using the credentials for another Amazon Web
    /// Services account, the details of that account.
    aws_account: ?AwsAccount = null,

    /// If the action was performed by an Amazon Web Services account that belongs
    /// to an Amazon Web Services service, the name of the service.
    aws_service: ?AwsService = null,

    /// If the action was performed with temporary security credentials that were
    /// obtained using the GetFederationToken operation of the Security Token
    /// Service (STS) API, the identifiers, session context, and other details about
    /// the identity.
    federated_user: ?FederatedUser = null,

    /// If the action was performed using the credentials for an Identity and Access
    /// Management (IAM) user, the name and other details about the user.
    iam_user: ?IamUser = null,

    /// If the action was performed using the credentials for your Amazon Web
    /// Services account, the details of your account.
    root: ?UserIdentityRoot = null,

    /// The type of entity that performed the action.
    @"type": ?UserIdentityType = null,

    pub const json_field_names = .{
        .assumed_role = "assumedRole",
        .aws_account = "awsAccount",
        .aws_service = "awsService",
        .federated_user = "federatedUser",
        .iam_user = "iamUser",
        .root = "root",
        .@"type" = "type",
    };
};
