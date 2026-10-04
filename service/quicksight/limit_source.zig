const std = @import("std");

/// The source from which an effective limit was inherited.
pub const LimitSource = enum {
    direct_user,
    group,
    role,
    account,
    system_default,

    pub const json_field_names = .{
        .direct_user = "DIRECT_USER",
        .group = "GROUP",
        .role = "ROLE",
        .account = "ACCOUNT",
        .system_default = "SYSTEM_DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .direct_user => "DIRECT_USER",
            .group => "GROUP",
            .role => "ROLE",
            .account => "ACCOUNT",
            .system_default => "SYSTEM_DEFAULT",
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
