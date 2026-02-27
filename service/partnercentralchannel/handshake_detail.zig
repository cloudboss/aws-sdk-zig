const ProgramManagementAccountHandshakeDetail = @import("program_management_account_handshake_detail.zig").ProgramManagementAccountHandshakeDetail;
const RevokeServicePeriodHandshakeDetail = @import("revoke_service_period_handshake_detail.zig").RevokeServicePeriodHandshakeDetail;
const StartServicePeriodHandshakeDetail = @import("start_service_period_handshake_detail.zig").StartServicePeriodHandshakeDetail;

/// Contains detailed information about different types of handshakes.
pub const HandshakeDetail = union(enum) {
    /// Details for a program management account handshake.
    program_management_account_handshake_detail: ?ProgramManagementAccountHandshakeDetail,
    /// Details for a revoke service period handshake.
    revoke_service_period_handshake_detail: ?RevokeServicePeriodHandshakeDetail,
    /// Details for a start service period handshake.
    start_service_period_handshake_detail: ?StartServicePeriodHandshakeDetail,

    pub const json_field_names = .{
        .program_management_account_handshake_detail = "programManagementAccountHandshakeDetail",
        .revoke_service_period_handshake_detail = "revokeServicePeriodHandshakeDetail",
        .start_service_period_handshake_detail = "startServicePeriodHandshakeDetail",
    };
};
