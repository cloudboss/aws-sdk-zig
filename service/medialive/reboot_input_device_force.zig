/// Whether or not to force reboot the input device.
pub const RebootInputDeviceForce = enum {
    no,
    yes,

    pub const json_field_names = .{
        .no = "NO",
        .yes = "YES",
    };
};
