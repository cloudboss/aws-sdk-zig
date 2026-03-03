const std = @import("std");

pub const ShiftType = enum {
    zonal_shift,
    practice_run,
    fis_experiment,
    zonal_autoshift,

    pub const json_field_names = .{
        .zonal_shift = "ZONAL_SHIFT",
        .practice_run = "PRACTICE_RUN",
        .fis_experiment = "FIS_EXPERIMENT",
        .zonal_autoshift = "ZONAL_AUTOSHIFT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zonal_shift => "ZONAL_SHIFT",
            .practice_run => "PRACTICE_RUN",
            .fis_experiment => "FIS_EXPERIMENT",
            .zonal_autoshift => "ZONAL_AUTOSHIFT",
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
