const std = @import("std");

pub const EntitlementDataUnit = enum {
    count,
    none,
    seconds,
    microseconds,
    milliseconds,
    bytes,
    kilobytes,
    megabytes,
    gigabytes,
    terabytes,
    bits,
    kilobits,
    megabits,
    gigabits,
    terabits,
    percent,
    bytes_per_second,
    kilobytes_per_second,
    megabytes_per_second,
    gigabytes_per_second,
    terabytes_per_second,
    bits_per_second,
    kilobits_per_second,
    megabits_per_second,
    gigabits_per_second,
    terabits_per_second,
    count_per_second,

    pub const json_field_names = .{
        .count = "Count",
        .none = "None",
        .seconds = "Seconds",
        .microseconds = "Microseconds",
        .milliseconds = "Milliseconds",
        .bytes = "Bytes",
        .kilobytes = "Kilobytes",
        .megabytes = "Megabytes",
        .gigabytes = "Gigabytes",
        .terabytes = "Terabytes",
        .bits = "Bits",
        .kilobits = "Kilobits",
        .megabits = "Megabits",
        .gigabits = "Gigabits",
        .terabits = "Terabits",
        .percent = "Percent",
        .bytes_per_second = "Bytes/Second",
        .kilobytes_per_second = "Kilobytes/Second",
        .megabytes_per_second = "Megabytes/Second",
        .gigabytes_per_second = "Gigabytes/Second",
        .terabytes_per_second = "Terabytes/Second",
        .bits_per_second = "Bits/Second",
        .kilobits_per_second = "Kilobits/Second",
        .megabits_per_second = "Megabits/Second",
        .gigabits_per_second = "Gigabits/Second",
        .terabits_per_second = "Terabits/Second",
        .count_per_second = "Count/Second",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "Count",
            .none => "None",
            .seconds => "Seconds",
            .microseconds => "Microseconds",
            .milliseconds => "Milliseconds",
            .bytes => "Bytes",
            .kilobytes => "Kilobytes",
            .megabytes => "Megabytes",
            .gigabytes => "Gigabytes",
            .terabytes => "Terabytes",
            .bits => "Bits",
            .kilobits => "Kilobits",
            .megabits => "Megabits",
            .gigabits => "Gigabits",
            .terabits => "Terabits",
            .percent => "Percent",
            .bytes_per_second => "Bytes/Second",
            .kilobytes_per_second => "Kilobytes/Second",
            .megabytes_per_second => "Megabytes/Second",
            .gigabytes_per_second => "Gigabytes/Second",
            .terabytes_per_second => "Terabytes/Second",
            .bits_per_second => "Bits/Second",
            .kilobits_per_second => "Kilobits/Second",
            .megabits_per_second => "Megabits/Second",
            .gigabits_per_second => "Gigabits/Second",
            .terabits_per_second => "Terabits/Second",
            .count_per_second => "Count/Second",
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
