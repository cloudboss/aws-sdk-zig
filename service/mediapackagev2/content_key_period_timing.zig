const std = @import("std");

pub const ContentKeyPeriodTiming = enum {
    index_only,
    start_end_only,
    index_with_start_end,

    pub const json_field_names = .{
        .index_only = "INDEX_ONLY",
        .start_end_only = "START_END_ONLY",
        .index_with_start_end = "INDEX_WITH_START_END",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .index_only => "INDEX_ONLY",
            .start_end_only => "START_END_ONLY",
            .index_with_start_end => "INDEX_WITH_START_END",
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
