const std = @import("std");

pub const SnowflakeS3BackupMode = enum {
    failed_data_only,
    all_data,

    pub const json_field_names = .{
        .failed_data_only = "FailedDataOnly",
        .all_data = "AllData",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed_data_only => "FailedDataOnly",
            .all_data => "AllData",
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
