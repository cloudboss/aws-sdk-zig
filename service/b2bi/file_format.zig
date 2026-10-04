const std = @import("std");

pub const FileFormat = enum {
    xml,
    json,
    not_used,

    pub const json_field_names = .{
        .xml = "XML",
        .json = "JSON",
        .not_used = "NOT_USED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .xml => "XML",
            .json => "JSON",
            .not_used => "NOT_USED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
