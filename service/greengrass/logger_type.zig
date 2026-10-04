const std = @import("std");

pub const LoggerType = enum {
    file_system,
    aws_cloud_watch,

    pub const json_field_names = .{
        .file_system = "FileSystem",
        .aws_cloud_watch = "AWSCloudWatch",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system => "FileSystem",
            .aws_cloud_watch => "AWSCloudWatch",
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
