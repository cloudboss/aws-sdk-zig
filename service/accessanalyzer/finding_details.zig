const ExternalAccessDetails = @import("external_access_details.zig").ExternalAccessDetails;
const InternalAccessDetails = @import("internal_access_details.zig").InternalAccessDetails;
const UnusedIamRoleDetails = @import("unused_iam_role_details.zig").UnusedIamRoleDetails;
const UnusedIamUserAccessKeyDetails = @import("unused_iam_user_access_key_details.zig").UnusedIamUserAccessKeyDetails;
const UnusedIamUserPasswordDetails = @import("unused_iam_user_password_details.zig").UnusedIamUserPasswordDetails;
const UnusedPermissionDetails = @import("unused_permission_details.zig").UnusedPermissionDetails;

/// Contains information about an external access or unused access finding. Only
/// one parameter can be used in a `FindingDetails` object.
pub const FindingDetails = union(enum) {
    /// The details for an external access analyzer finding.
    external_access_details: ?ExternalAccessDetails,
    /// The details for an internal access analyzer finding. This contains
    /// information about access patterns identified within your Amazon Web Services
    /// organization or account.
    internal_access_details: ?InternalAccessDetails,
    /// The details for an unused access analyzer finding with an unused IAM role
    /// finding type.
    unused_iam_role_details: ?UnusedIamRoleDetails,
    /// The details for an unused access analyzer finding with an unused IAM user
    /// access key finding type.
    unused_iam_user_access_key_details: ?UnusedIamUserAccessKeyDetails,
    /// The details for an unused access analyzer finding with an unused IAM user
    /// password finding type.
    unused_iam_user_password_details: ?UnusedIamUserPasswordDetails,
    /// The details for an unused access analyzer finding with an unused permission
    /// finding type.
    unused_permission_details: ?UnusedPermissionDetails,

    pub const json_field_names = .{
        .external_access_details = "externalAccessDetails",
        .internal_access_details = "internalAccessDetails",
        .unused_iam_role_details = "unusedIamRoleDetails",
        .unused_iam_user_access_key_details = "unusedIamUserAccessKeyDetails",
        .unused_iam_user_password_details = "unusedIamUserPasswordDetails",
        .unused_permission_details = "unusedPermissionDetails",
    };
};
