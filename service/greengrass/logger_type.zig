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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
