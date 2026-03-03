const std = @import("std");

pub const PowerConnector = enum {
    l6_30_p,
    iec309,
    ah530_p7_w,
    ah532_p6_w,
    cs8365_c,

    pub const json_field_names = .{
        .l6_30_p = "L6_30P",
        .iec309 = "IEC309",
        .ah530_p7_w = "AH530P7W",
        .ah532_p6_w = "AH532P6W",
        .cs8365_c = "CS8365C",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .l6_30_p => "L6_30P",
            .iec309 => "IEC309",
            .ah530_p7_w => "AH530P7W",
            .ah532_p6_w => "AH532P6W",
            .cs8365_c => "CS8365C",
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
