pub const AssociationErrorCode = enum {
    insufficient_diskspace,
    insufficient_memory,
    unsupported_operating_system,
    internal_server_error,
    workspace_unreachable,
    application_oldversionexist_failure,

    pub const json_field_names = .{
        .insufficient_diskspace = "INSUFFICIENT_DISKSPACE",
        .insufficient_memory = "INSUFFICIENT_MEMORY",
        .unsupported_operating_system = "UNSUPPORTED_OPERATING_SYSTEM",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
        .workspace_unreachable = "WORKSPACE_UNREACHABLE",
        .application_oldversionexist_failure = "APPLICATION_OLDVERSIONEXIST_FAILURE",
    };
};
