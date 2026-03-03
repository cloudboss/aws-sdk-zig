const std = @import("std");

pub const StandardUnit = enum {
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
    count,
    bytes_second,
    kilobytes_second,
    megabytes_second,
    gigabytes_second,
    terabytes_second,
    bits_second,
    kilobits_second,
    megabits_second,
    gigabits_second,
    terabits_second,
    count_second,
    none,

    pub const json_field_names = .{
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
        .count = "Count",
        .bytes_second = "Bytes/Second",
        .kilobytes_second = "Kilobytes/Second",
        .megabytes_second = "Megabytes/Second",
        .gigabytes_second = "Gigabytes/Second",
        .terabytes_second = "Terabytes/Second",
        .bits_second = "Bits/Second",
        .kilobits_second = "Kilobits/Second",
        .megabits_second = "Megabits/Second",
        .gigabits_second = "Gigabits/Second",
        .terabits_second = "Terabits/Second",
        .count_second = "Count/Second",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
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
            .count => "Count",
            .bytes_second => "Bytes/Second",
            .kilobytes_second => "Kilobytes/Second",
            .megabytes_second => "Megabytes/Second",
            .gigabytes_second => "Gigabytes/Second",
            .terabytes_second => "Terabytes/Second",
            .bits_second => "Bits/Second",
            .kilobits_second => "Kilobits/Second",
            .megabits_second => "Megabits/Second",
            .gigabits_second => "Gigabits/Second",
            .terabits_second => "Terabits/Second",
            .count_second => "Count/Second",
            .none => "None",
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
