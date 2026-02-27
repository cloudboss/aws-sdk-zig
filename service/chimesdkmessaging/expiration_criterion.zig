pub const ExpirationCriterion = enum {
    created_timestamp,
    last_message_timestamp,

    pub const json_field_names = .{
        .created_timestamp = "CREATED_TIMESTAMP",
        .last_message_timestamp = "LAST_MESSAGE_TIMESTAMP",
    };
};
