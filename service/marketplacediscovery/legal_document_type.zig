const std = @import("std");

pub const LegalDocumentType = enum {
    custom_eula,
    custom_dsa,
    enterprise_eula,
    standard_eula,
    standard_dsa,

    pub const json_field_names = .{
        .custom_eula = "CustomEula",
        .custom_dsa = "CustomDsa",
        .enterprise_eula = "EnterpriseEula",
        .standard_eula = "StandardEula",
        .standard_dsa = "StandardDsa",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_eula => "CustomEula",
            .custom_dsa => "CustomDsa",
            .enterprise_eula => "EnterpriseEula",
            .standard_eula => "StandardEula",
            .standard_dsa => "StandardDsa",
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
