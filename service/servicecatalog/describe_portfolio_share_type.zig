const std = @import("std");

pub const DescribePortfolioShareType = enum {
    account,
    organization,
    organizational_unit,
    organization_member_account,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
        .organization_member_account = "ORGANIZATION_MEMBER_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .organization => "ORGANIZATION",
            .organizational_unit => "ORGANIZATIONAL_UNIT",
            .organization_member_account => "ORGANIZATION_MEMBER_ACCOUNT",
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
