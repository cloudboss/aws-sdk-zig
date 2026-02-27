const LDAPSStatus = @import("ldaps_status.zig").LDAPSStatus;

/// Contains general information about the LDAPS settings.
pub const LDAPSSettingInfo = struct {
    /// The date and time when the LDAPS settings were last updated.
    last_updated_date_time: ?i64,

    /// The state of the LDAPS settings.
    ldaps_status: ?LDAPSStatus,

    /// Describes a state change for LDAPS.
    ldaps_status_reason: ?[]const u8,

    pub const json_field_names = .{
        .last_updated_date_time = "LastUpdatedDateTime",
        .ldaps_status = "LDAPSStatus",
        .ldaps_status_reason = "LDAPSStatusReason",
    };
};
