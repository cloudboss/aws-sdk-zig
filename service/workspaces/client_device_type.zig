pub const ClientDeviceType = enum {
    device_type_windows,
    device_type_osx,
    device_type_android,
    device_type_ios,
    device_type_linux,
    device_type_web,

    pub const json_field_names = .{
        .device_type_windows = "DEVICE_TYPE_WINDOWS",
        .device_type_osx = "DEVICE_TYPE_OSX",
        .device_type_android = "DEVICE_TYPE_ANDROID",
        .device_type_ios = "DEVICE_TYPE_IOS",
        .device_type_linux = "DEVICE_TYPE_LINUX",
        .device_type_web = "DEVICE_TYPE_WEB",
    };
};
