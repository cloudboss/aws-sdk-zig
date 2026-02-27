pub const UserStackAssociationErrorCode = enum {
    stack_not_found,
    user_name_not_found,
    directory_not_found,
    internal_error,

    pub const json_field_names = .{
        .stack_not_found = "STACK_NOT_FOUND",
        .user_name_not_found = "USER_NAME_NOT_FOUND",
        .directory_not_found = "DIRECTORY_NOT_FOUND",
        .internal_error = "INTERNAL_ERROR",
    };
};
