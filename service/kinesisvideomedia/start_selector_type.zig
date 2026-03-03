const std = @import("std");

pub const StartSelectorType = enum {
    fragment_number,
    server_timestamp,
    producer_timestamp,
    now,
    earliest,
    continuation_token,

    pub const json_field_names = .{
        .fragment_number = "FRAGMENT_NUMBER",
        .server_timestamp = "SERVER_TIMESTAMP",
        .producer_timestamp = "PRODUCER_TIMESTAMP",
        .now = "NOW",
        .earliest = "EARLIEST",
        .continuation_token = "CONTINUATION_TOKEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fragment_number => "FRAGMENT_NUMBER",
            .server_timestamp => "SERVER_TIMESTAMP",
            .producer_timestamp => "PRODUCER_TIMESTAMP",
            .now => "NOW",
            .earliest => "EARLIEST",
            .continuation_token => "CONTINUATION_TOKEN",
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
