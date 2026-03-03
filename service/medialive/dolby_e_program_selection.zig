const std = @import("std");

/// Dolby EProgram Selection
pub const DolbyEProgramSelection = enum {
    all_channels,
    program_1,
    program_2,
    program_3,
    program_4,
    program_5,
    program_6,
    program_7,
    program_8,

    pub const json_field_names = .{
        .all_channels = "ALL_CHANNELS",
        .program_1 = "PROGRAM_1",
        .program_2 = "PROGRAM_2",
        .program_3 = "PROGRAM_3",
        .program_4 = "PROGRAM_4",
        .program_5 = "PROGRAM_5",
        .program_6 = "PROGRAM_6",
        .program_7 = "PROGRAM_7",
        .program_8 = "PROGRAM_8",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_channels => "ALL_CHANNELS",
            .program_1 => "PROGRAM_1",
            .program_2 => "PROGRAM_2",
            .program_3 => "PROGRAM_3",
            .program_4 => "PROGRAM_4",
            .program_5 => "PROGRAM_5",
            .program_6 => "PROGRAM_6",
            .program_7 => "PROGRAM_7",
            .program_8 => "PROGRAM_8",
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
