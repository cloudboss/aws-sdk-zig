const std = @import("std");

pub const OutpostMode = enum {
    single_outpost,
    cross_outpost,

    pub const json_field_names = .{
        .single_outpost = "single-outpost",
        .cross_outpost = "cross-outpost",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_outpost => "single-outpost",
            .cross_outpost => "cross-outpost",
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
