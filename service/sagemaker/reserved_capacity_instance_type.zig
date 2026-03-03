const std = @import("std");

pub const ReservedCapacityInstanceType = enum {
    ml_p4_d_24_xlarge,
    ml_p5_48_xlarge,
    ml_p5_e_48_xlarge,
    ml_p5_en_48_xlarge,
    ml_trn1_32_xlarge,
    ml_trn2_48_xlarge,
    ml_p6_b200_48_xlarge,
    ml_p4_de_24_xlarge,
    ml_p6_e_gb200_36_xlarge,
    ml_p5_4_xlarge,
    ml_p6_b300_48_xlarge,

    pub const json_field_names = .{
        .ml_p4_d_24_xlarge = "ml.p4d.24xlarge",
        .ml_p5_48_xlarge = "ml.p5.48xlarge",
        .ml_p5_e_48_xlarge = "ml.p5e.48xlarge",
        .ml_p5_en_48_xlarge = "ml.p5en.48xlarge",
        .ml_trn1_32_xlarge = "ml.trn1.32xlarge",
        .ml_trn2_48_xlarge = "ml.trn2.48xlarge",
        .ml_p6_b200_48_xlarge = "ml.p6-b200.48xlarge",
        .ml_p4_de_24_xlarge = "ml.p4de.24xlarge",
        .ml_p6_e_gb200_36_xlarge = "ml.p6e-gb200.36xlarge",
        .ml_p5_4_xlarge = "ml.p5.4xlarge",
        .ml_p6_b300_48_xlarge = "ml.p6-b300.48xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ml_p4_d_24_xlarge => "ml.p4d.24xlarge",
            .ml_p5_48_xlarge => "ml.p5.48xlarge",
            .ml_p5_e_48_xlarge => "ml.p5e.48xlarge",
            .ml_p5_en_48_xlarge => "ml.p5en.48xlarge",
            .ml_trn1_32_xlarge => "ml.trn1.32xlarge",
            .ml_trn2_48_xlarge => "ml.trn2.48xlarge",
            .ml_p6_b200_48_xlarge => "ml.p6-b200.48xlarge",
            .ml_p4_de_24_xlarge => "ml.p4de.24xlarge",
            .ml_p6_e_gb200_36_xlarge => "ml.p6e-gb200.36xlarge",
            .ml_p5_4_xlarge => "ml.p5.4xlarge",
            .ml_p6_b300_48_xlarge => "ml.p6-b300.48xlarge",
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
