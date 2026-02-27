/// List of status supported by automation jobs
pub const AutomationJobStatus = enum {
    created,
    in_progress,
    success,
    service_error,
    client_error,

    pub const json_field_names = .{
        .created = "CREATED",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .service_error = "SERVICE_ERROR",
        .client_error = "CLIENT_ERROR",
    };
};
