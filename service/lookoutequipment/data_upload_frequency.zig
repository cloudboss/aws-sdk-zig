const std = @import("std");

pub const DataUploadFrequency = enum {
    pt5_m,
    pt10_m,
    pt15_m,
    pt30_m,
    pt1_h,

    pub const json_field_names = .{
        .pt5_m = "PT5M",
        .pt10_m = "PT10M",
        .pt15_m = "PT15M",
        .pt30_m = "PT30M",
        .pt1_h = "PT1H",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pt5_m => "PT5M",
            .pt10_m => "PT10M",
            .pt15_m => "PT15M",
            .pt30_m => "PT30M",
            .pt1_h => "PT1H",
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
