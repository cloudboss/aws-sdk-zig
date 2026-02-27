const ProgramManagementAccountTypeFilters = @import("program_management_account_type_filters.zig").ProgramManagementAccountTypeFilters;
const RevokeServicePeriodTypeFilters = @import("revoke_service_period_type_filters.zig").RevokeServicePeriodTypeFilters;
const StartServicePeriodTypeFilters = @import("start_service_period_type_filters.zig").StartServicePeriodTypeFilters;

/// Type-specific filters for listing channel handshakes.
pub const ListChannelHandshakesTypeFilters = union(enum) {
    /// Filters specific to program management account handshakes.
    program_management_account_type_filters: ?ProgramManagementAccountTypeFilters,
    /// Filters specific to revoke service period handshakes.
    revoke_service_period_type_filters: ?RevokeServicePeriodTypeFilters,
    /// Filters specific to start service period handshakes.
    start_service_period_type_filters: ?StartServicePeriodTypeFilters,

    pub const json_field_names = .{
        .program_management_account_type_filters = "programManagementAccountTypeFilters",
        .revoke_service_period_type_filters = "revokeServicePeriodTypeFilters",
        .start_service_period_type_filters = "startServicePeriodTypeFilters",
    };
};
