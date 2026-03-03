const std = @import("std");

pub const TagStatus = enum {
    tagged,
    untagged,
    any,

    pub const json_field_names = .{
        .tagged = "TAGGED",
        .untagged = "UNTAGGED",
        .any = "ANY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tagged => "TAGGED",
            .untagged => "UNTAGGED",
            .any => "ANY",
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
