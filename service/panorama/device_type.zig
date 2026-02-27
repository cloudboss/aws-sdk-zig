pub const DeviceType = enum {
    panorama_appliance_developer_kit,
    panorama_appliance,

    pub const json_field_names = .{
        .panorama_appliance_developer_kit = "PANORAMA_APPLIANCE_DEVELOPER_KIT",
        .panorama_appliance = "PANORAMA_APPLIANCE",
    };
};
