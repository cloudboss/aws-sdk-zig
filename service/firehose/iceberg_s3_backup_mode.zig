const std = @import("std");

pub const IcebergS3BackupMode = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
