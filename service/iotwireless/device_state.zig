/// Device state defines the device status of sidewalk device.
pub const DeviceState = enum {
    provisioned,
    registerednotseen,
    registeredreachable,
    registeredunreachable,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .registerednotseen = "REGISTEREDNOTSEEN",
        .registeredreachable = "REGISTEREDREACHABLE",
        .registeredunreachable = "REGISTEREDUNREACHABLE",
    };
};
