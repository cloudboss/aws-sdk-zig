/// The status of software on the input device.
pub const DeviceUpdateStatus = enum {
    up_to_date,
    not_up_to_date,
    updating,

    pub const json_field_names = .{
        .up_to_date = "UP_TO_DATE",
        .not_up_to_date = "NOT_UP_TO_DATE",
        .updating = "UPDATING",
    };
};
