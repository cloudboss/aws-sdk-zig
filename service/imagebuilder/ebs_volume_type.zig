const std = @import("std");

pub const EbsVolumeType = enum {
    standard,
    io1,
    io2,
    gp2,
    gp3,
    sc1,
    st1,

    pub const json_field_names = .{
        .standard = "standard",
        .io1 = "io1",
        .io2 = "io2",
        .gp2 = "gp2",
        .gp3 = "gp3",
        .sc1 = "sc1",
        .st1 = "st1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "standard",
            .io1 => "io1",
            .io2 => "io2",
            .gp2 => "gp2",
            .gp3 => "gp3",
            .sc1 => "sc1",
            .st1 => "st1",
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
