const aws = @import("aws");

const InternalAccessType = @import("internal_access_type.zig").InternalAccessType;
const PrincipalType = @import("principal_type.zig").PrincipalType;
const ResourceControlPolicyRestriction = @import("resource_control_policy_restriction.zig").ResourceControlPolicyRestriction;
const ServiceControlPolicyRestriction = @import("service_control_policy_restriction.zig").ServiceControlPolicyRestriction;
const FindingSource = @import("finding_source.zig").FindingSource;

/// Contains information about an internal access finding. This includes details
/// about the access that was identified within your Amazon Web Services
/// organization or account.
pub const InternalAccessDetails = struct {
    /// The type of internal access identified in the finding. This indicates how
    /// the access is granted within your Amazon Web Services environment.
    access_type: ?InternalAccessType = null,

    /// The action in the analyzed policy statement that has internal access
    /// permission to use.
    action: ?[]const []const u8 = null,

    /// The condition in the analyzed policy statement that resulted in an internal
    /// access finding.
    condition: ?[]const aws.map.StringMapEntry = null,

    /// The principal that has access to a resource within the internal environment.
    principal: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Web Services account ID that owns the principal identified in the
    /// internal access finding.
    principal_owner_account: ?[]const u8 = null,

    /// The type of principal identified in the internal access finding, such as IAM
    /// role or IAM user.
    principal_type: ?PrincipalType = null,

    /// The type of restriction applied to the finding by the resource owner with an
    /// Organizations resource control policy (RCP).
    ///
    /// * `APPLICABLE`: There is an RCP present in the organization but IAM Access
    ///   Analyzer does not include it in the evaluation of effective permissions.
    ///   For example, if `s3:DeleteObject` is blocked by the RCP and the
    ///   restriction is `APPLICABLE`, then `s3:DeleteObject` would still be
    ///   included in the list of actions for the finding. Only applicable to
    ///   internal access findings with the account as the zone of trust.
    /// * `FAILED_TO_EVALUATE_RCP`: There was an error evaluating the RCP.
    /// * `NOT_APPLICABLE`: There was no RCP present in the organization. For
    ///   internal access findings with the account as the zone of trust,
    ///   `NOT_APPLICABLE` could also indicate that there was no RCP applicable to
    ///   the resource.
    /// * `APPLIED`: An RCP is present in the organization and IAM Access Analyzer
    ///   included it in the evaluation of effective permissions. For example, if
    ///   `s3:DeleteObject` is blocked by the RCP and the restriction is `APPLIED`,
    ///   then `s3:DeleteObject` would not be included in the list of actions for
    ///   the finding. Only applicable to internal access findings with the
    ///   organization as the zone of trust.
    resource_control_policy_restriction: ?ResourceControlPolicyRestriction = null,

    /// The type of restriction applied to the finding by an Organizations service
    /// control policy (SCP).
    ///
    /// * `APPLICABLE`: There is an SCP present in the organization but IAM Access
    ///   Analyzer does not include it in the evaluation of effective permissions.
    ///   Only applicable to internal access findings with the account as the zone
    ///   of trust.
    /// * `FAILED_TO_EVALUATE_SCP`: There was an error evaluating the SCP.
    /// * `NOT_APPLICABLE`: There was no SCP present in the organization. For
    ///   internal access findings with the account as the zone of trust,
    ///   `NOT_APPLICABLE` could also indicate that there was no SCP applicable to
    ///   the principal.
    /// * `APPLIED`: An SCP is present in the organization and IAM Access Analyzer
    ///   included it in the evaluation of effective permissions. Only applicable to
    ///   internal access findings with the organization as the zone of trust.
    service_control_policy_restriction: ?ServiceControlPolicyRestriction = null,

    /// The sources of the internal access finding. This indicates how the access
    /// that generated the finding is granted within your Amazon Web Services
    /// environment.
    sources: ?[]const FindingSource = null,

    pub const json_field_names = .{
        .access_type = "accessType",
        .action = "action",
        .condition = "condition",
        .principal = "principal",
        .principal_owner_account = "principalOwnerAccount",
        .principal_type = "principalType",
        .resource_control_policy_restriction = "resourceControlPolicyRestriction",
        .service_control_policy_restriction = "serviceControlPolicyRestriction",
        .sources = "sources",
    };
};
