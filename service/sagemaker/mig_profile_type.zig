const std = @import("std");

pub const MIGProfileType = enum {
    mig_1_g_5_gb,
    mig_1_g_10_gb,
    mig_1_g_18_gb,
    mig_1_g_20_gb,
    mig_1_g_23_gb,
    mig_1_g_35_gb,
    mig_1_g_45_gb,
    mig_1_g_47_gb,
    mig_2_g_10_gb,
    mig_2_g_20_gb,
    mig_2_g_35_gb,
    mig_2_g_45_gb,
    mig_2_g_47_gb,
    mig_3_g_20_gb,
    mig_3_g_40_gb,
    mig_3_g_71_gb,
    mig_3_g_90_gb,
    mig_3_g_93_gb,
    mig_4_g_20_gb,
    mig_4_g_40_gb,
    mig_4_g_71_gb,
    mig_4_g_90_gb,
    mig_4_g_93_gb,
    mig_7_g_40_gb,
    mig_7_g_80_gb,
    mig_7_g_141_gb,
    mig_7_g_180_gb,
    mig_7_g_186_gb,

    pub const json_field_names = .{
        .mig_1_g_5_gb = "mig-1g.5gb",
        .mig_1_g_10_gb = "mig-1g.10gb",
        .mig_1_g_18_gb = "mig-1g.18gb",
        .mig_1_g_20_gb = "mig-1g.20gb",
        .mig_1_g_23_gb = "mig-1g.23gb",
        .mig_1_g_35_gb = "mig-1g.35gb",
        .mig_1_g_45_gb = "mig-1g.45gb",
        .mig_1_g_47_gb = "mig-1g.47gb",
        .mig_2_g_10_gb = "mig-2g.10gb",
        .mig_2_g_20_gb = "mig-2g.20gb",
        .mig_2_g_35_gb = "mig-2g.35gb",
        .mig_2_g_45_gb = "mig-2g.45gb",
        .mig_2_g_47_gb = "mig-2g.47gb",
        .mig_3_g_20_gb = "mig-3g.20gb",
        .mig_3_g_40_gb = "mig-3g.40gb",
        .mig_3_g_71_gb = "mig-3g.71gb",
        .mig_3_g_90_gb = "mig-3g.90gb",
        .mig_3_g_93_gb = "mig-3g.93gb",
        .mig_4_g_20_gb = "mig-4g.20gb",
        .mig_4_g_40_gb = "mig-4g.40gb",
        .mig_4_g_71_gb = "mig-4g.71gb",
        .mig_4_g_90_gb = "mig-4g.90gb",
        .mig_4_g_93_gb = "mig-4g.93gb",
        .mig_7_g_40_gb = "mig-7g.40gb",
        .mig_7_g_80_gb = "mig-7g.80gb",
        .mig_7_g_141_gb = "mig-7g.141gb",
        .mig_7_g_180_gb = "mig-7g.180gb",
        .mig_7_g_186_gb = "mig-7g.186gb",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mig_1_g_5_gb => "mig-1g.5gb",
            .mig_1_g_10_gb => "mig-1g.10gb",
            .mig_1_g_18_gb => "mig-1g.18gb",
            .mig_1_g_20_gb => "mig-1g.20gb",
            .mig_1_g_23_gb => "mig-1g.23gb",
            .mig_1_g_35_gb => "mig-1g.35gb",
            .mig_1_g_45_gb => "mig-1g.45gb",
            .mig_1_g_47_gb => "mig-1g.47gb",
            .mig_2_g_10_gb => "mig-2g.10gb",
            .mig_2_g_20_gb => "mig-2g.20gb",
            .mig_2_g_35_gb => "mig-2g.35gb",
            .mig_2_g_45_gb => "mig-2g.45gb",
            .mig_2_g_47_gb => "mig-2g.47gb",
            .mig_3_g_20_gb => "mig-3g.20gb",
            .mig_3_g_40_gb => "mig-3g.40gb",
            .mig_3_g_71_gb => "mig-3g.71gb",
            .mig_3_g_90_gb => "mig-3g.90gb",
            .mig_3_g_93_gb => "mig-3g.93gb",
            .mig_4_g_20_gb => "mig-4g.20gb",
            .mig_4_g_40_gb => "mig-4g.40gb",
            .mig_4_g_71_gb => "mig-4g.71gb",
            .mig_4_g_90_gb => "mig-4g.90gb",
            .mig_4_g_93_gb => "mig-4g.93gb",
            .mig_7_g_40_gb => "mig-7g.40gb",
            .mig_7_g_80_gb => "mig-7g.80gb",
            .mig_7_g_141_gb => "mig-7g.141gb",
            .mig_7_g_180_gb => "mig-7g.180gb",
            .mig_7_g_186_gb => "mig-7g.186gb",
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
