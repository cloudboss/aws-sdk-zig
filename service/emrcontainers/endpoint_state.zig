pub const EndpointState = enum {
    creating,
    active,
    terminating,
    terminated,
    terminated_with_errors,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .terminated_with_errors = "TERMINATED_WITH_ERRORS",
    };
};
