const std = @import("std");

pub const ShardIteratorType = enum {
    trim_horizon,
    latest,
    at_sequence_number,
    after_sequence_number,

    pub const json_field_names = .{
        .trim_horizon = "TRIM_HORIZON",
        .latest = "LATEST",
        .at_sequence_number = "AT_SEQUENCE_NUMBER",
        .after_sequence_number = "AFTER_SEQUENCE_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trim_horizon => "TRIM_HORIZON",
            .latest => "LATEST",
            .at_sequence_number => "AT_SEQUENCE_NUMBER",
            .after_sequence_number => "AFTER_SEQUENCE_NUMBER",
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
