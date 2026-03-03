const std = @import("std");

pub const VolumeType = enum {
    standard,
    io_1,
    io_2,
    gp_2,
    sc_1,
    st_1,
    gp_3,

    pub const json_field_names = .{
        .standard = "standard",
        .io_1 = "io1",
        .io_2 = "io2",
        .gp_2 = "gp2",
        .sc_1 = "sc1",
        .st_1 = "st1",
        .gp_3 = "gp3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "standard",
            .io_1 => "io1",
            .io_2 => "io2",
            .gp_2 => "gp2",
            .sc_1 => "sc1",
            .st_1 => "st1",
            .gp_3 => "gp3",
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
