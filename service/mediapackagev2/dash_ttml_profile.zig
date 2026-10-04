const std = @import("std");

pub const DashTtmlProfile = enum {
    imsc_1,
    ebu_tt_d_101,

    pub const json_field_names = .{
        .imsc_1 = "IMSC_1",
        .ebu_tt_d_101 = "EBU_TT_D_101",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .imsc_1 => "IMSC_1",
            .ebu_tt_d_101 => "EBU_TT_D_101",
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
