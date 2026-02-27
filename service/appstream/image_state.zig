pub const ImageState = enum {
    pending,
    available,
    failed,
    copying,
    deleting,
    creating,
    importing,
    validating,

    pub const json_field_names = .{
        .pending = "PENDING",
        .available = "AVAILABLE",
        .failed = "FAILED",
        .copying = "COPYING",
        .deleting = "DELETING",
        .creating = "CREATING",
        .importing = "IMPORTING",
        .validating = "VALIDATING",
    };
};
