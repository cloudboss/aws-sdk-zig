const std = @import("std");

pub const SnowballType = enum {
    standard,
    edge,
    edge_c,
    edge_cg,
    edge_s,
    snc1_hdd,
    snc1_ssd,
    v3_5_c,
    v3_5_s,
    rack_5_u_c,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .edge = "EDGE",
        .edge_c = "EDGE_C",
        .edge_cg = "EDGE_CG",
        .edge_s = "EDGE_S",
        .snc1_hdd = "SNC1_HDD",
        .snc1_ssd = "SNC1_SSD",
        .v3_5_c = "V3_5C",
        .v3_5_s = "V3_5S",
        .rack_5_u_c = "RACK_5U_C",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .edge => "EDGE",
            .edge_c => "EDGE_C",
            .edge_cg => "EDGE_CG",
            .edge_s => "EDGE_S",
            .snc1_hdd => "SNC1_HDD",
            .snc1_ssd => "SNC1_SSD",
            .v3_5_c => "V3_5C",
            .v3_5_s => "V3_5S",
            .rack_5_u_c => "RACK_5U_C",
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
