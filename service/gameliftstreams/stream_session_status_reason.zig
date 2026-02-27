pub const StreamSessionStatusReason = enum {
    internal_error,
    invalid_signal_request,
    placement_timeout,
    app_log_s3_destination_error,
    application_exit,
    connection_timeout,
    reconnection_timeout,
    max_session_length_timeout,
    idle_timeout,
    api_terminated,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_signal_request = "INVALID_SIGNAL_REQUEST",
        .placement_timeout = "PLACEMENT_TIMEOUT",
        .app_log_s3_destination_error = "APP_LOG_S3_DESTINATION_ERROR",
        .application_exit = "APPLICATION_EXIT",
        .connection_timeout = "CONNECTION_TIMEOUT",
        .reconnection_timeout = "RECONNECTION_TIMEOUT",
        .max_session_length_timeout = "MAX_SESSION_LENGTH_TIMEOUT",
        .idle_timeout = "IDLE_TIMEOUT",
        .api_terminated = "API_TERMINATED",
    };
};
