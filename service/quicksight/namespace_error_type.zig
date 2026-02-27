pub const NamespaceErrorType = enum {
    permission_denied,
    internal_service_error,

    pub const json_field_names = .{
        .permission_denied = "PERMISSION_DENIED",
        .internal_service_error = "INTERNAL_SERVICE_ERROR",
    };
};
