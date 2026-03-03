const std = @import("std");

pub const IpamPolicyManagedBy = enum {
    account,
    delegated_administrator_for_ipam,

    pub const json_field_names = .{
        .account = "account",
        .delegated_administrator_for_ipam = "delegated-administrator-for-ipam",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "account",
            .delegated_administrator_for_ipam => "delegated-administrator-for-ipam",
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
