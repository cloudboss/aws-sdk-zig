/// Represents one level of an Organizations hierarchy—the organization root, an
/// organizational
/// unit (OU), or an account—together with the service control policies (SCPs)
/// that apply at
/// that level. Each element in the list represents one level of the hierarchy,
/// ordered from
/// the organization root down to the account.
///
/// For more information about SCPs, see [Service control
/// policies
/// (SCPs)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html) in the *Organizations User Guide*.
pub const OrderedOrganizationPolicyType = struct {
    /// A list of SCP documents that apply at this level of the Organizations
    /// hierarchy. Each document
    /// is specified as a string containing the complete, valid JSON text of an SCP.
    service_control_policy_input_list: ?[]const []const u8 = null,
};
