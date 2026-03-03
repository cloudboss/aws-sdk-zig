const std = @import("std");

pub const AccountTakeoverEventActionType = enum {
    block,
    mfa_if_configured,
    mfa_required,
    no_action,

    pub const json_field_names = .{
        .block = "BLOCK",
        .mfa_if_configured = "MFA_IF_CONFIGURED",
        .mfa_required = "MFA_REQUIRED",
        .no_action = "NO_ACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .block => "BLOCK",
            .mfa_if_configured => "MFA_IF_CONFIGURED",
            .mfa_required => "MFA_REQUIRED",
            .no_action => "NO_ACTION",
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
