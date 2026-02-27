pub const ExpirationCriterion = enum {
    created_timestamp,

    pub const json_field_names = .{
        .created_timestamp = "CREATED_TIMESTAMP",
    };
};
