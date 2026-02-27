pub const ImageStatus = enum {
    pending,
    creating,
    building,
    testing,
    distributing,
    integrating,
    available,
    cancelled,
    failed,
    deprecated,
    deleted,
    disabled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .creating = "CREATING",
        .building = "BUILDING",
        .testing = "TESTING",
        .distributing = "DISTRIBUTING",
        .integrating = "INTEGRATING",
        .available = "AVAILABLE",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .deprecated = "DEPRECATED",
        .deleted = "DELETED",
        .disabled = "DISABLED",
    };
};
