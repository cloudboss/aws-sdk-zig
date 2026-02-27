pub const ErrorType = enum {
    /// An API request validation exception
    validation_exception,
    /// An API request retrieving an item that can't be found
    resource_not_found_exception,

    pub const json_field_names = .{
        .validation_exception = "VALIDATION_EXCEPTION",
        .resource_not_found_exception = "RESOURCE_NOT_FOUND_EXCEPTION",
    };
};
