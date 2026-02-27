pub const NameServersUpdateStateCode = enum {
    succeeded,
    pending,
    failed,
    started,

    pub const json_field_names = .{
        .succeeded = "Succeeded",
        .pending = "Pending",
        .failed = "Failed",
        .started = "Started",
    };
};
