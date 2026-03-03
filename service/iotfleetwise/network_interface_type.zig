const std = @import("std");

pub const NetworkInterfaceType = enum {
    can_interface,
    obd_interface,
    vehicle_middleware,
    custom_decoding_interface,

    pub const json_field_names = .{
        .can_interface = "CAN_INTERFACE",
        .obd_interface = "OBD_INTERFACE",
        .vehicle_middleware = "VEHICLE_MIDDLEWARE",
        .custom_decoding_interface = "CUSTOM_DECODING_INTERFACE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .can_interface => "CAN_INTERFACE",
            .obd_interface => "OBD_INTERFACE",
            .vehicle_middleware => "VEHICLE_MIDDLEWARE",
            .custom_decoding_interface => "CUSTOM_DECODING_INTERFACE",
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
