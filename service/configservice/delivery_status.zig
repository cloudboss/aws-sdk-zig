pub const DeliveryStatus = enum {
    success,
    failure,
    not_applicable,

    pub const json_field_names = .{
        .success = "Success",
        .failure = "Failure",
        .not_applicable = "Not_Applicable",
    };
};
