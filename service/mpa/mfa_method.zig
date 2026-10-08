const MfaSyncStatus = @import("mfa_sync_status.zig").MfaSyncStatus;
const MfaType = @import("mfa_type.zig").MfaType;

/// MFA configuration and sycnronization status for an approver
pub const MfaMethod = struct {
    /// Indicates if the approver's MFA device is in-sync with the Identity Source
    sync_status: MfaSyncStatus,

    /// The type of MFA configuration used by the approver
    type: MfaType,

    pub const json_field_names = .{
        .sync_status = "SyncStatus",
        .type = "Type",
    };
};
