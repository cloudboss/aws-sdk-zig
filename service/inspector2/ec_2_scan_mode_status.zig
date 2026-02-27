pub const Ec2ScanModeStatus = enum {
    success,
    pending,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .pending = "PENDING",
    };
};
