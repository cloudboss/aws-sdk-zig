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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
