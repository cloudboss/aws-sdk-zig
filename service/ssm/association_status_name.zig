pub const AssociationStatusName = enum {
    pending,
    success,
    failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .success = "Success",
        .failed = "Failed",
    };
};
