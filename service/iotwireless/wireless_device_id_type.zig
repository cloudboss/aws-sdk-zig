const std = @import("std");

pub const WirelessDeviceIdType = enum {
    wireless_device_id,
    dev_eui,
    thing_name,
    sidewalk_manufacturing_sn,

    pub const json_field_names = .{
        .wireless_device_id = "WirelessDeviceId",
        .dev_eui = "DevEui",
        .thing_name = "ThingName",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .wireless_device_id => "WirelessDeviceId",
            .dev_eui => "DevEui",
            .thing_name => "ThingName",
            .sidewalk_manufacturing_sn => "SidewalkManufacturingSn",
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
