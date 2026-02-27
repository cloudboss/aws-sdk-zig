const ScopeStatus = @import("scope_status.zig").ScopeStatus;

/// A summary of information about a scope, including the ARN, target ID, and
/// Amazon Web Services Region.
pub const ScopeSummary = struct {
    /// The Amazon Resource Name (ARN) of the scope.
    scope_arn: []const u8,

    /// The identifier for the scope that includes the resources that you want to
    /// get data results for. A scope ID is an internally-generated identifier that
    /// includes all the resources for the accounts in a scope.
    scope_id: []const u8,

    /// The status for a scope. The status can be one of the following: `SUCCEEDED`,
    /// `IN_PROGRESS`, `FAILED`, `DEACTIVATING`, or `DEACTIVATED`.
    ///
    /// A status of `DEACTIVATING` means that you've requested a scope to be
    /// deactivated and Network Flow Monitor is in the process of deactivating the
    /// scope. A status of `DEACTIVATED` means that the deactivating process is
    /// complete.
    status: ScopeStatus,

    pub const json_field_names = .{
        .scope_arn = "scopeArn",
        .scope_id = "scopeId",
        .status = "status",
    };
};
