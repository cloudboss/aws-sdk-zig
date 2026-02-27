pub const PackageStatus = enum {
    copying,
    copy_failed,
    validating,
    validation_failed,
    available,
    deleting,
    deleted,
    delete_failed,

    pub const json_field_names = .{
        .copying = "COPYING",
        .copy_failed = "COPY_FAILED",
        .validating = "VALIDATING",
        .validation_failed = "VALIDATION_FAILED",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
    };
};
