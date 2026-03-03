const std = @import("std");

pub const ScopeName = enum {
    organization,
    account_id,
    resource_arn,

    pub const json_field_names = .{
        .organization = "Organization",
        .account_id = "AccountId",
        .resource_arn = "ResourceArn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .organization => "Organization",
            .account_id => "AccountId",
            .resource_arn => "ResourceArn",
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
