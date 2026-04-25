/// The configuration of the resource share
pub const ResourceShareConfiguration = struct {
    /// Specifies whether the consumer account retains access to the resource share
    /// after leaving the organization.
    retain_sharing_on_account_leave_organization: ?bool = null,

    pub const json_field_names = .{
        .retain_sharing_on_account_leave_organization = "retainSharingOnAccountLeaveOrganization",
    };
};
