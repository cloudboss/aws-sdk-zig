const std = @import("std");

pub const VcfVersion = enum {
    vcf_5_2_1,
    vcf_5_2_2,
    self_deployed,

    pub const json_field_names = .{
        .vcf_5_2_1 = "VCF-5.2.1",
        .vcf_5_2_2 = "VCF-5.2.2",
        .self_deployed = "SELF_DEPLOYED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vcf_5_2_1 => "VCF-5.2.1",
            .vcf_5_2_2 => "VCF-5.2.2",
            .self_deployed => "SELF_DEPLOYED",
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
