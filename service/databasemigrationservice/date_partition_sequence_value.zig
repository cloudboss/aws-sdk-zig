const std = @import("std");

pub const DatePartitionSequenceValue = enum {
    yyyymmdd,
    yyyymmddhh,
    yyyymm,
    mmyyyydd,
    ddmmyyyy,

    pub const json_field_names = .{
        .yyyymmdd = "YYYYMMDD",
        .yyyymmddhh = "YYYYMMDDHH",
        .yyyymm = "YYYYMM",
        .mmyyyydd = "MMYYYYDD",
        .ddmmyyyy = "DDMMYYYY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .yyyymmdd => "YYYYMMDD",
            .yyyymmddhh => "YYYYMMDDHH",
            .yyyymm => "YYYYMM",
            .mmyyyydd => "MMYYYYDD",
            .ddmmyyyy => "DDMMYYYY",
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
