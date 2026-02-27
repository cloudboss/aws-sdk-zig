pub const ConflictExceptionReason = enum {
    already_exists,
    subresources_exist,
    invalid_state,

    pub const json_field_names = .{
        .already_exists = "ALREADY_EXISTS",
        .subresources_exist = "SUBRESOURCES_EXIST",
        .invalid_state = "INVALID_STATE",
    };
};
