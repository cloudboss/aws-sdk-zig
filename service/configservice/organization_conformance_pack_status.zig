const OrganizationResourceStatus = @import("organization_resource_status.zig").OrganizationResourceStatus;

/// Returns the status for an organization conformance pack in an organization.
pub const OrganizationConformancePackStatus = struct {
    /// An error code that is returned when organization conformance pack creation
    /// or deletion has failed in a member account.
    error_code: ?[]const u8 = null,

    /// An error message indicating that organization conformance pack creation or
    /// deletion failed due to an error.
    error_message: ?[]const u8 = null,

    /// The timestamp of the last update.
    last_update_time: ?i64 = null,

    /// The name that you assign to organization conformance pack.
    organization_conformance_pack_name: []const u8,

    /// Indicates deployment status of an organization conformance pack.
    /// When management account calls PutOrganizationConformancePack for the first
    /// time,
    /// conformance pack status is created in all the member accounts.
    /// When management account calls PutOrganizationConformancePack for the second
    /// time,
    /// conformance pack status is updated in all the member accounts.
    /// Additionally, conformance pack status is updated when one or more member
    /// accounts join or leave an
    /// organization.
    /// Conformance pack status is deleted when the management account deletes
    /// OrganizationConformancePack in all the member accounts and disables service
    /// access for `config-multiaccountsetup.amazonaws.com`.
    ///
    /// Config sets the state of the conformance pack to:
    ///
    /// * `CREATE_SUCCESSFUL` when an organization conformance pack has been
    ///   successfully created in all the member accounts.
    ///
    /// * `CREATE_IN_PROGRESS` when an organization conformance pack creation is in
    ///   progress.
    ///
    /// * `CREATE_FAILED` when an organization conformance pack creation failed in
    ///   one or more member accounts within that organization.
    ///
    /// * `DELETE_FAILED` when an organization conformance pack deletion failed in
    ///   one or more member accounts within that organization.
    ///
    /// * `DELETE_IN_PROGRESS` when an organization conformance pack deletion is in
    ///   progress.
    ///
    /// * `DELETE_SUCCESSFUL` when an organization conformance pack has been
    ///   successfully deleted from all the member accounts.
    ///
    /// * `UPDATE_SUCCESSFUL` when an organization conformance pack has been
    ///   successfully updated in all the member accounts.
    ///
    /// * `UPDATE_IN_PROGRESS` when an organization conformance pack update is in
    ///   progress.
    ///
    /// * `UPDATE_FAILED` when an organization conformance pack update failed in one
    ///   or more member accounts within that organization.
    status: OrganizationResourceStatus,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .last_update_time = "LastUpdateTime",
        .organization_conformance_pack_name = "OrganizationConformancePackName",
        .status = "Status",
    };
};
