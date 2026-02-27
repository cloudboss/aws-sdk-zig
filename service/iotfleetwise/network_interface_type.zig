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
};
