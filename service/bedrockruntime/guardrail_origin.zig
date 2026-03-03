const std = @import("std");

pub const GuardrailOrigin = enum {
    request,
    account_enforced,
    organization_enforced,

    pub const json_field_names = .{
        .request = "REQUEST",
        .account_enforced = "ACCOUNT_ENFORCED",
        .organization_enforced = "ORGANIZATION_ENFORCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request => "REQUEST",
            .account_enforced => "ACCOUNT_ENFORCED",
            .organization_enforced => "ORGANIZATION_ENFORCED",
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
