pub const ApplicationDiscoveryStatus = enum {
    success,
    registration_failed,
    refresh_failed,
    registering,
    deleting,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .registration_failed = "REGISTRATION_FAILED",
        .refresh_failed = "REFRESH_FAILED",
        .registering = "REGISTERING",
        .deleting = "DELETING",
    };
};
