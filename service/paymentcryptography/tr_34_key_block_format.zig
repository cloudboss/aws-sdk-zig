const std = @import("std");

pub const Tr34KeyBlockFormat = enum {
    x9_tr34_2012,

    pub const json_field_names = .{
        .x9_tr34_2012 = "X9_TR34_2012",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .x9_tr34_2012 => "X9_TR34_2012",
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
