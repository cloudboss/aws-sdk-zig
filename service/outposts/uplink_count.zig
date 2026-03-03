const std = @import("std");

pub const UplinkCount = enum {
    uplink_count_1,
    uplink_count_2,
    uplink_count_3,
    uplink_count_4,
    uplink_count_5,
    uplink_count_6,
    uplink_count_7,
    uplink_count_8,
    uplink_count_12,
    uplink_count_16,

    pub const json_field_names = .{
        .uplink_count_1 = "UPLINK_COUNT_1",
        .uplink_count_2 = "UPLINK_COUNT_2",
        .uplink_count_3 = "UPLINK_COUNT_3",
        .uplink_count_4 = "UPLINK_COUNT_4",
        .uplink_count_5 = "UPLINK_COUNT_5",
        .uplink_count_6 = "UPLINK_COUNT_6",
        .uplink_count_7 = "UPLINK_COUNT_7",
        .uplink_count_8 = "UPLINK_COUNT_8",
        .uplink_count_12 = "UPLINK_COUNT_12",
        .uplink_count_16 = "UPLINK_COUNT_16",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .uplink_count_1 => "UPLINK_COUNT_1",
            .uplink_count_2 => "UPLINK_COUNT_2",
            .uplink_count_3 => "UPLINK_COUNT_3",
            .uplink_count_4 => "UPLINK_COUNT_4",
            .uplink_count_5 => "UPLINK_COUNT_5",
            .uplink_count_6 => "UPLINK_COUNT_6",
            .uplink_count_7 => "UPLINK_COUNT_7",
            .uplink_count_8 => "UPLINK_COUNT_8",
            .uplink_count_12 => "UPLINK_COUNT_12",
            .uplink_count_16 => "UPLINK_COUNT_16",
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
