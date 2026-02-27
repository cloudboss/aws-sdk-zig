pub const DeviceAvailability = enum {
    temporary_not_available,
    busy,
    available,
    highly_available,

    pub const json_field_names = .{
        .temporary_not_available = "TEMPORARY_NOT_AVAILABLE",
        .busy = "BUSY",
        .available = "AVAILABLE",
        .highly_available = "HIGHLY_AVAILABLE",
    };
};
