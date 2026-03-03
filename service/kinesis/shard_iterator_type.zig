const std = @import("std");

pub const ShardIteratorType = enum {
    at_sequence_number,
    after_sequence_number,
    trim_horizon,
    latest,
    at_timestamp,

    pub const json_field_names = .{
        .at_sequence_number = "AT_SEQUENCE_NUMBER",
        .after_sequence_number = "AFTER_SEQUENCE_NUMBER",
        .trim_horizon = "TRIM_HORIZON",
        .latest = "LATEST",
        .at_timestamp = "AT_TIMESTAMP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .at_sequence_number => "AT_SEQUENCE_NUMBER",
            .after_sequence_number => "AFTER_SEQUENCE_NUMBER",
            .trim_horizon => "TRIM_HORIZON",
            .latest => "LATEST",
            .at_timestamp => "AT_TIMESTAMP",
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
