pub const ProvisionStateEnum = enum {
    allocating,
    allocated,
    deallocating,
    deallocated,
    error_allocating,
    error_deallocating,

    pub const json_field_names = .{
        .allocating = "ALLOCATING",
        .allocated = "ALLOCATED",
        .deallocating = "DEALLOCATING",
        .deallocated = "DEALLOCATED",
        .error_allocating = "ERROR_ALLOCATING",
        .error_deallocating = "ERROR_DEALLOCATING",
    };
};
