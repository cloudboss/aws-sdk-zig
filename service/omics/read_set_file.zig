const std = @import("std");

pub const ReadSetFile = enum {
    source1,
    source2,
    index,

    pub const json_field_names = .{
        .source1 = "SOURCE1",
        .source2 = "SOURCE2",
        .index = "INDEX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source1 => "SOURCE1",
            .source2 => "SOURCE2",
            .index => "INDEX",
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
