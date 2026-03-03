const std = @import("std");

pub const PhysicalConnectorType = enum {
    rj45,
    sfp_plus,
    qsfp,
    rj45_2,
    wifi,

    pub const json_field_names = .{
        .rj45 = "RJ45",
        .sfp_plus = "SFP_PLUS",
        .qsfp = "QSFP",
        .rj45_2 = "RJ45_2",
        .wifi = "WIFI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rj45 => "RJ45",
            .sfp_plus => "SFP_PLUS",
            .qsfp => "QSFP",
            .rj45_2 => "RJ45_2",
            .wifi => "WIFI",
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
