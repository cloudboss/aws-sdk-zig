pub const ResolverQueryLogConfigAssociationError = enum {
    none,
    destination_not_found,
    access_denied,
    internal_service_error,

    pub const json_field_names = .{
        .none = "None",
        .destination_not_found = "DestinationNotFound",
        .access_denied = "AccessDenied",
        .internal_service_error = "InternalServiceError",
    };
};
