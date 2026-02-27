pub const RecorderStatus = enum {
    pending,
    success,
    failure,
    not_applicable,

    pub const json_field_names = .{
        .pending = "Pending",
        .success = "Success",
        .failure = "Failure",
        .not_applicable = "NotApplicable",
    };
};
