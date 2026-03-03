const std = @import("std");

pub const Destination = enum {
    cloudwatch_logs,
    s3,

    pub const json_field_names = .{
        .cloudwatch_logs = "CLOUDWATCH_LOGS",
        .s3 = "S3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloudwatch_logs => "CLOUDWATCH_LOGS",
            .s3 => "S3",
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
