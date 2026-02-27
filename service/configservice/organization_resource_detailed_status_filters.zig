const OrganizationResourceDetailedStatus = @import("organization_resource_detailed_status.zig").OrganizationResourceDetailedStatus;

/// Status filter object to filter results based on specific member account ID
/// or status type for an organization conformance pack.
pub const OrganizationResourceDetailedStatusFilters = struct {
    /// The 12-digit account ID of the member account within an organization.
    account_id: ?[]const u8,

    /// Indicates deployment status for conformance pack in a member account.
    /// When management account calls `PutOrganizationConformancePack` action for
    /// the first time, conformance pack status is created in the member account.
    /// When management account calls `PutOrganizationConformancePack` action for
    /// the second time, conformance pack status is updated in the member account.
    /// Conformance pack status is deleted when the management account deletes
    /// `OrganizationConformancePack` and disables service access for
    /// `config-multiaccountsetup.amazonaws.com`.
    ///
    /// Config sets the state of the conformance pack to:
    ///
    /// * `CREATE_SUCCESSFUL` when conformance pack has been created in the member
    ///   account.
    ///
    /// * `CREATE_IN_PROGRESS` when conformance pack is being created in the member
    ///   account.
    ///
    /// * `CREATE_FAILED` when conformance pack creation has failed in the member
    ///   account.
    ///
    /// * `DELETE_FAILED` when conformance pack deletion has failed in the member
    ///   account.
    ///
    /// * `DELETE_IN_PROGRESS` when conformance pack is being deleted in the member
    ///   account.
    ///
    /// * `DELETE_SUCCESSFUL` when conformance pack has been deleted in the member
    ///   account.
    ///
    /// * `UPDATE_SUCCESSFUL` when conformance pack has been updated in the member
    ///   account.
    ///
    /// * `UPDATE_IN_PROGRESS` when conformance pack is being updated in the member
    ///   account.
    ///
    /// * `UPDATE_FAILED` when conformance pack deletion has failed in the member
    ///   account.
    status: ?OrganizationResourceDetailedStatus,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .status = "Status",
    };
};
