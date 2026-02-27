pub const ErrorCode = enum {
    duplicate_input,
    resource_does_not_exist,
    resource_already_exists,
    internal_server_failure,

    pub const json_field_names = .{
        .duplicate_input = "DUPLICATE_INPUT",
        .resource_does_not_exist = "RESOURCE_DOES_NOT_EXIST",
        .resource_already_exists = "RESOURCE_ALREADY_EXISTS",
        .internal_server_failure = "INTERNAL_SERVER_FAILURE",
    };
};
