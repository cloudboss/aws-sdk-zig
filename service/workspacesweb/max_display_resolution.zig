const std = @import("std");

pub const MaxDisplayResolution = enum {
    resolution_dci_4_k,
    resolution_uhd_4_k,
    resolution_1440_p_ultra_wide,
    resolution_1440_p,
    resolution_1080_p,
    resolution_720_p,
    resolution_768_p,
    resolution_600_p,

    pub const json_field_names = .{
        .resolution_dci_4_k = "size4096X2160",
        .resolution_uhd_4_k = "size3840X2160",
        .resolution_1440_p_ultra_wide = "size3440X1440",
        .resolution_1440_p = "size2560X1440",
        .resolution_1080_p = "size1920X1080",
        .resolution_720_p = "size1280X720",
        .resolution_768_p = "size1024X768",
        .resolution_600_p = "size800X600",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resolution_dci_4_k => "size4096X2160",
            .resolution_uhd_4_k => "size3840X2160",
            .resolution_1440_p_ultra_wide => "size3440X1440",
            .resolution_1440_p => "size2560X1440",
            .resolution_1080_p => "size1920X1080",
            .resolution_720_p => "size1280X720",
            .resolution_768_p => "size1024X768",
            .resolution_600_p => "size800X600",
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
