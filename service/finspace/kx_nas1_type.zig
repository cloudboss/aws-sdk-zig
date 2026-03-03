const std = @import("std");

pub const KxNAS1Type = enum {
    ssd_1000,
    ssd_250,
    hdd_12,

    pub const json_field_names = .{
        .ssd_1000 = "SSD_1000",
        .ssd_250 = "SSD_250",
        .hdd_12 = "HDD_12",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ssd_1000 => "SSD_1000",
            .ssd_250 => "SSD_250",
            .hdd_12 => "HDD_12",
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
