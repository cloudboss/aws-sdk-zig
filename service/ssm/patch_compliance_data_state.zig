const std = @import("std");

pub const PatchComplianceDataState = enum {
    installed,
    installed_other,
    installed_pending_reboot,
    installed_rejected,
    missing,
    not_applicable,
    failed,
    available_security_update,

    pub const json_field_names = .{
        .installed = "INSTALLED",
        .installed_other = "INSTALLED_OTHER",
        .installed_pending_reboot = "INSTALLED_PENDING_REBOOT",
        .installed_rejected = "INSTALLED_REJECTED",
        .missing = "MISSING",
        .not_applicable = "NOT_APPLICABLE",
        .failed = "FAILED",
        .available_security_update = "AVAILABLE_SECURITY_UPDATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .installed => "INSTALLED",
            .installed_other => "INSTALLED_OTHER",
            .installed_pending_reboot => "INSTALLED_PENDING_REBOOT",
            .installed_rejected => "INSTALLED_REJECTED",
            .missing => "MISSING",
            .not_applicable => "NOT_APPLICABLE",
            .failed => "FAILED",
            .available_security_update => "AVAILABLE_SECURITY_UPDATE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
