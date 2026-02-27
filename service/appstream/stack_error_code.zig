pub const StackErrorCode = enum {
    storage_connector_error,
    internal_service_error,

    pub const json_field_names = .{
        .storage_connector_error = "STORAGE_CONNECTOR_ERROR",
        .internal_service_error = "INTERNAL_SERVICE_ERROR",
    };
};
