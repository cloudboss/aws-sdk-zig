const std = @import("std");

/// Specify how often MediaConvert sends STATUS_UPDATE events to Amazon
/// CloudWatch Events. Set the interval, in seconds, between status updates.
/// MediaConvert sends an update at this interval from the time the service
/// begins processing your job to the time it completes the transcode or
/// encounters an error.
pub const StatusUpdateInterval = enum {
    seconds_10,
    seconds_12,
    seconds_15,
    seconds_20,
    seconds_30,
    seconds_60,
    seconds_120,
    seconds_180,
    seconds_240,
    seconds_300,
    seconds_360,
    seconds_420,
    seconds_480,
    seconds_540,
    seconds_600,

    pub const json_field_names = .{
        .seconds_10 = "SECONDS_10",
        .seconds_12 = "SECONDS_12",
        .seconds_15 = "SECONDS_15",
        .seconds_20 = "SECONDS_20",
        .seconds_30 = "SECONDS_30",
        .seconds_60 = "SECONDS_60",
        .seconds_120 = "SECONDS_120",
        .seconds_180 = "SECONDS_180",
        .seconds_240 = "SECONDS_240",
        .seconds_300 = "SECONDS_300",
        .seconds_360 = "SECONDS_360",
        .seconds_420 = "SECONDS_420",
        .seconds_480 = "SECONDS_480",
        .seconds_540 = "SECONDS_540",
        .seconds_600 = "SECONDS_600",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .seconds_10 => "SECONDS_10",
            .seconds_12 => "SECONDS_12",
            .seconds_15 => "SECONDS_15",
            .seconds_20 => "SECONDS_20",
            .seconds_30 => "SECONDS_30",
            .seconds_60 => "SECONDS_60",
            .seconds_120 => "SECONDS_120",
            .seconds_180 => "SECONDS_180",
            .seconds_240 => "SECONDS_240",
            .seconds_300 => "SECONDS_300",
            .seconds_360 => "SECONDS_360",
            .seconds_420 => "SECONDS_420",
            .seconds_480 => "SECONDS_480",
            .seconds_540 => "SECONDS_540",
            .seconds_600 => "SECONDS_600",
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
