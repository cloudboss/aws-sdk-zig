const std = @import("std");

pub const AcceleratorName = enum {
    a100,
    v100,
    k80,
    t4,
    m60,
    radeon_pro_v520,
    vu9_p,

    pub const json_field_names = .{
        .a100 = "a100",
        .v100 = "v100",
        .k80 = "k80",
        .t4 = "t4",
        .m60 = "m60",
        .radeon_pro_v520 = "radeon-pro-v520",
        .vu9_p = "vu9p",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .a100 => "a100",
            .v100 => "v100",
            .k80 => "k80",
            .t4 => "t4",
            .m60 => "m60",
            .radeon_pro_v520 => "radeon-pro-v520",
            .vu9_p => "vu9p",
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
