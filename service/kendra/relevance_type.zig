const std = @import("std");

pub const RelevanceType = enum {
    relevant,
    not_relevant,

    pub const json_field_names = .{
        .relevant = "RELEVANT",
        .not_relevant = "NOT_RELEVANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .relevant => "RELEVANT",
            .not_relevant => "NOT_RELEVANT",
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
