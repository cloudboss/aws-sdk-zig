const std = @import("std");

pub const Type = enum {
    account,
    organization,
    account_unused_access,
    organization_unused_access,
    account_internal_access,
    organization_internal_access,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
        .account_unused_access = "ACCOUNT_UNUSED_ACCESS",
        .organization_unused_access = "ORGANIZATION_UNUSED_ACCESS",
        .account_internal_access = "ACCOUNT_INTERNAL_ACCESS",
        .organization_internal_access = "ORGANIZATION_INTERNAL_ACCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .organization => "ORGANIZATION",
            .account_unused_access => "ACCOUNT_UNUSED_ACCESS",
            .organization_unused_access => "ORGANIZATION_UNUSED_ACCESS",
            .account_internal_access => "ACCOUNT_INTERNAL_ACCESS",
            .organization_internal_access => "ORGANIZATION_INTERNAL_ACCESS",
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
