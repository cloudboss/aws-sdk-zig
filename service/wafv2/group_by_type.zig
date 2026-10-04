const std = @import("std");

pub const GroupByType = enum {
    name,
    category,
    intent,
    organization,
    webacl,

    pub const json_field_names = .{
        .name = "NAME",
        .category = "CATEGORY",
        .intent = "INTENT",
        .organization = "ORGANIZATION",
        .webacl = "WEBACL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .category => "CATEGORY",
            .intent => "INTENT",
            .organization => "ORGANIZATION",
            .webacl => "WEBACL",
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
