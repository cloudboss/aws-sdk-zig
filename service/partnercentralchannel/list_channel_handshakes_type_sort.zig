const ProgramManagementAccountTypeSort = @import("program_management_account_type_sort.zig").ProgramManagementAccountTypeSort;
const RevokeServicePeriodTypeSort = @import("revoke_service_period_type_sort.zig").RevokeServicePeriodTypeSort;
const StartServicePeriodTypeSort = @import("start_service_period_type_sort.zig").StartServicePeriodTypeSort;

/// Type-specific sorting options for listing channel handshakes.
pub const ListChannelHandshakesTypeSort = union(enum) {
    /// Sorting options specific to program management account handshakes.
    program_management_account_type_sort: ?ProgramManagementAccountTypeSort,
    /// Sorting options specific to revoke service period handshakes.
    revoke_service_period_type_sort: ?RevokeServicePeriodTypeSort,
    /// Sorting options specific to start service period handshakes.
    start_service_period_type_sort: ?StartServicePeriodTypeSort,

    pub const json_field_names = .{
        .program_management_account_type_sort = "programManagementAccountTypeSort",
        .revoke_service_period_type_sort = "revokeServicePeriodTypeSort",
        .start_service_period_type_sort = "startServicePeriodTypeSort",
    };
};
