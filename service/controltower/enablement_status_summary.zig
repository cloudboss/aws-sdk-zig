const EnablementStatus = @import("enablement_status.zig").EnablementStatus;

/// The deployment summary of an `EnabledControl` or `EnabledBaseline` resource.
pub const EnablementStatusSummary = struct {
    /// The last operation identifier for the enabled resource.
    last_operation_identifier: ?[]const u8,

    /// The deployment status of the enabled resource.
    ///
    /// Valid values:
    ///
    /// * `SUCCEEDED`: The `EnabledControl` or `EnabledBaseline` configuration was
    ///   deployed successfully.
    /// * `UNDER_CHANGE`: The `EnabledControl` or `EnabledBaseline` configuration is
    ///   changing.
    /// * `FAILED`: The `EnabledControl` or `EnabledBaseline` configuration failed
    ///   to deploy.
    status: ?EnablementStatus,

    pub const json_field_names = .{
        .last_operation_identifier = "lastOperationIdentifier",
        .status = "status",
    };
};
