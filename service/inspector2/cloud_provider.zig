const std = @import("std");

pub const CloudProvider = enum {
    aws,
    azure,
    not_applicable,

    pub const json_field_names = .{
        .aws = "AWS",
        .azure = "AZURE",
        .not_applicable = "NOT_APPLICABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "AWS",
            .azure => "AZURE",
            .not_applicable => "NOT_APPLICABLE",
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
