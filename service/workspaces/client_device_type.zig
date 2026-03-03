const std = @import("std");

pub const ClientDeviceType = enum {
    device_type_windows,
    device_type_osx,
    device_type_android,
    device_type_ios,
    device_type_linux,
    device_type_web,

    pub const json_field_names = .{
        .device_type_windows = "DeviceTypeWindows",
        .device_type_osx = "DeviceTypeOsx",
        .device_type_android = "DeviceTypeAndroid",
        .device_type_ios = "DeviceTypeIos",
        .device_type_linux = "DeviceTypeLinux",
        .device_type_web = "DeviceTypeWeb",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .device_type_windows => "DeviceTypeWindows",
            .device_type_osx => "DeviceTypeOsx",
            .device_type_android => "DeviceTypeAndroid",
            .device_type_ios => "DeviceTypeIos",
            .device_type_linux => "DeviceTypeLinux",
            .device_type_web => "DeviceTypeWeb",
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
