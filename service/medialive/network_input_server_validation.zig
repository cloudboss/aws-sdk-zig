/// Network Input Server Validation
pub const NetworkInputServerValidation = enum {
    check_cryptography_and_validate_name,
    check_cryptography_only,

    pub const json_field_names = .{
        .check_cryptography_and_validate_name = "CHECK_CRYPTOGRAPHY_AND_VALIDATE_NAME",
        .check_cryptography_only = "CHECK_CRYPTOGRAPHY_ONLY",
    };
};
