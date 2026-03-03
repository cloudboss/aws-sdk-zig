const std = @import("std");

pub const ConfigurationCheckType = enum {
    sap_check_01,
    sap_check_02,
    sap_check_03,

    pub const json_field_names = .{
        .sap_check_01 = "SAP_CHECK_01",
        .sap_check_02 = "SAP_CHECK_02",
        .sap_check_03 = "SAP_CHECK_03",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sap_check_01 => "SAP_CHECK_01",
            .sap_check_02 => "SAP_CHECK_02",
            .sap_check_03 => "SAP_CHECK_03",
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
