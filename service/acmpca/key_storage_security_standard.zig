const std = @import("std");

pub const KeyStorageSecurityStandard = enum {
    fips_140_2_level_2_or_higher,
    fips_140_2_level_3_or_higher,
    ccpc_level_1_or_higher,

    pub const json_field_names = .{
        .fips_140_2_level_2_or_higher = "FIPS_140_2_LEVEL_2_OR_HIGHER",
        .fips_140_2_level_3_or_higher = "FIPS_140_2_LEVEL_3_OR_HIGHER",
        .ccpc_level_1_or_higher = "CCPC_LEVEL_1_OR_HIGHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fips_140_2_level_2_or_higher => "FIPS_140_2_LEVEL_2_OR_HIGHER",
            .fips_140_2_level_3_or_higher => "FIPS_140_2_LEVEL_3_OR_HIGHER",
            .ccpc_level_1_or_higher => "CCPC_LEVEL_1_OR_HIGHER",
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
