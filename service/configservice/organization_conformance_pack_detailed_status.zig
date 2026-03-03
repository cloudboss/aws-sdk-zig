const OrganizationResourceDetailedStatus = @import("organization_resource_detailed_status.zig").OrganizationResourceDetailedStatus;

/// Organization conformance pack creation or deletion status in each member
/// account.
/// This includes the name of the conformance pack, the status, error code and
/// error message
/// when the conformance pack creation or deletion failed.
pub const OrganizationConformancePackDetailedStatus = struct {
    /// The 12-digit account ID of a member account.
    account_id: []const u8,

    /// The name of conformance pack deployed in the member account.
    conformance_pack_name: []const u8,

    /// An error code that is returned when conformance pack creation or
    /// deletion failed in the member account.
    error_code: ?[]const u8 = null,

    /// An error message indicating that conformance pack account creation or
    /// deletion
    /// has failed due to an error in the member account.
    error_message: ?[]const u8 = null,

    /// The timestamp of the last status update.
    last_update_time: ?i64 = null,

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
    status: OrganizationResourceDetailedStatus,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .conformance_pack_name = "ConformancePackName",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .last_update_time = "LastUpdateTime",
        .status = "Status",
    };
};
