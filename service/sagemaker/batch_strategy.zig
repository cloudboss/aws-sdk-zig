const std = @import("std");

pub const BatchStrategy = enum {
    multi_record,
    single_record,

    pub const json_field_names = .{
        .multi_record = "MultiRecord",
        .single_record = "SingleRecord",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_record => "MultiRecord",
            .single_record => "SingleRecord",
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
