const std = @import("std");

pub const Coverage = enum {
    entire_organization,
    management_account_only,

    pub const json_field_names = .{
        .entire_organization = "ENTIRE_ORGANIZATION",
        .management_account_only = "MANAGEMENT_ACCOUNT_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entire_organization => "ENTIRE_ORGANIZATION",
            .management_account_only => "MANAGEMENT_ACCOUNT_ONLY",
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
