pub const NamespaceStatus = enum {
    created,
    creating,
    deleting,
    retryable_failure,
    non_retryable_failure,

    pub const json_field_names = .{
        .created = "CREATED",
        .creating = "CREATING",
        .deleting = "DELETING",
        .retryable_failure = "RETRYABLE_FAILURE",
        .non_retryable_failure = "NON_RETRYABLE_FAILURE",
    };
};
