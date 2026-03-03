const std = @import("std");

pub const AcceleratorName = enum {
    a100,
    inferentia,
    k520,
    k80,
    m60,
    radeon_pro_v520,
    t4,
    vu9_p,
    v100,
    a10_g,
    h100,
    t4_g,
    l40_s,
    l4,
    gaudi_hl_205,
    inferentia2,
    trainium,
    trainium2,
    u30,

    pub const json_field_names = .{
        .a100 = "a100",
        .inferentia = "inferentia",
        .k520 = "k520",
        .k80 = "k80",
        .m60 = "m60",
        .radeon_pro_v520 = "radeon-pro-v520",
        .t4 = "t4",
        .vu9_p = "vu9p",
        .v100 = "v100",
        .a10_g = "a10g",
        .h100 = "h100",
        .t4_g = "t4g",
        .l40_s = "l40s",
        .l4 = "l4",
        .gaudi_hl_205 = "gaudi-hl-205",
        .inferentia2 = "inferentia2",
        .trainium = "trainium",
        .trainium2 = "trainium2",
        .u30 = "u30",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .a100 => "a100",
            .inferentia => "inferentia",
            .k520 => "k520",
            .k80 => "k80",
            .m60 => "m60",
            .radeon_pro_v520 => "radeon-pro-v520",
            .t4 => "t4",
            .vu9_p => "vu9p",
            .v100 => "v100",
            .a10_g => "a10g",
            .h100 => "h100",
            .t4_g => "t4g",
            .l40_s => "l40s",
            .l4 => "l4",
            .gaudi_hl_205 => "gaudi-hl-205",
            .inferentia2 => "inferentia2",
            .trainium => "trainium",
            .trainium2 => "trainium2",
            .u30 => "u30",
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
