const std = @import("std");

pub const OpticalStandard = enum {
    optic_10_gbase_sr,
    optic_10_gbase_ir,
    optic_10_gbase_lr,
    optic_40_gbase_sr,
    optic_40_gbase_esr,
    optic_40_gbase_ir4_lr4_l,
    optic_40_gbase_lr4,
    optic_100_gbase_sr4,
    optic_100_gbase_cwdm4,
    optic_100_gbase_lr4,
    optic_100_g_psm4_msa,
    optic_1000_base_lx,
    optic_1000_base_sx,

    pub const json_field_names = .{
        .optic_10_gbase_sr = "OPTIC_10GBASE_SR",
        .optic_10_gbase_ir = "OPTIC_10GBASE_IR",
        .optic_10_gbase_lr = "OPTIC_10GBASE_LR",
        .optic_40_gbase_sr = "OPTIC_40GBASE_SR",
        .optic_40_gbase_esr = "OPTIC_40GBASE_ESR",
        .optic_40_gbase_ir4_lr4_l = "OPTIC_40GBASE_IR4_LR4L",
        .optic_40_gbase_lr4 = "OPTIC_40GBASE_LR4",
        .optic_100_gbase_sr4 = "OPTIC_100GBASE_SR4",
        .optic_100_gbase_cwdm4 = "OPTIC_100GBASE_CWDM4",
        .optic_100_gbase_lr4 = "OPTIC_100GBASE_LR4",
        .optic_100_g_psm4_msa = "OPTIC_100G_PSM4_MSA",
        .optic_1000_base_lx = "OPTIC_1000BASE_LX",
        .optic_1000_base_sx = "OPTIC_1000BASE_SX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .optic_10_gbase_sr => "OPTIC_10GBASE_SR",
            .optic_10_gbase_ir => "OPTIC_10GBASE_IR",
            .optic_10_gbase_lr => "OPTIC_10GBASE_LR",
            .optic_40_gbase_sr => "OPTIC_40GBASE_SR",
            .optic_40_gbase_esr => "OPTIC_40GBASE_ESR",
            .optic_40_gbase_ir4_lr4_l => "OPTIC_40GBASE_IR4_LR4L",
            .optic_40_gbase_lr4 => "OPTIC_40GBASE_LR4",
            .optic_100_gbase_sr4 => "OPTIC_100GBASE_SR4",
            .optic_100_gbase_cwdm4 => "OPTIC_100GBASE_CWDM4",
            .optic_100_gbase_lr4 => "OPTIC_100GBASE_LR4",
            .optic_100_g_psm4_msa => "OPTIC_100G_PSM4_MSA",
            .optic_1000_base_lx => "OPTIC_1000BASE_LX",
            .optic_1000_base_sx => "OPTIC_1000BASE_SX",
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
