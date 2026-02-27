pub const ChangeTokenStatus = enum {
    provisioned,
    pending,
    insync,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .pending = "PENDING",
        .insync = "INSYNC",
    };
};
