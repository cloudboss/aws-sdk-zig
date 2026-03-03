const std = @import("std");

pub const Colorimetry = enum {
    bt601,
    bt709,
    bt2020,
    bt2100,
    st2065_1,
    st2065_3,
    xyz,

    pub const json_field_names = .{
        .bt601 = "BT601",
        .bt709 = "BT709",
        .bt2020 = "BT2020",
        .bt2100 = "BT2100",
        .st2065_1 = "ST2065-1",
        .st2065_3 = "ST2065-3",
        .xyz = "XYZ",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bt601 => "BT601",
            .bt709 => "BT709",
            .bt2020 => "BT2020",
            .bt2100 => "BT2100",
            .st2065_1 => "ST2065-1",
            .st2065_3 => "ST2065-3",
            .xyz => "XYZ",
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
