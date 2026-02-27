pub const PackageVersionErrorCode = enum {
    already_exists,
    mismatched_revision,
    mismatched_status,
    not_allowed,
    not_found,
    skipped,

    pub const json_field_names = .{
        .already_exists = "ALREADY_EXISTS",
        .mismatched_revision = "MISMATCHED_REVISION",
        .mismatched_status = "MISMATCHED_STATUS",
        .not_allowed = "NOT_ALLOWED",
        .not_found = "NOT_FOUND",
        .skipped = "SKIPPED",
    };
};
