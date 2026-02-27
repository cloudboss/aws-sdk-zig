pub const DataAssetActivityStatus = enum {
    failed,
    publishing_failed,
    succeeded_created,
    succeeded_updated,
    skipped_already_imported,
    skipped_archived,
    skipped_no_access,
    unchanged,

    pub const json_field_names = .{
        .failed = "FAILED",
        .publishing_failed = "PUBLISHING_FAILED",
        .succeeded_created = "SUCCEEDED_CREATED",
        .succeeded_updated = "SUCCEEDED_UPDATED",
        .skipped_already_imported = "SKIPPED_ALREADY_IMPORTED",
        .skipped_archived = "SKIPPED_ARCHIVED",
        .skipped_no_access = "SKIPPED_NO_ACCESS",
        .unchanged = "UNCHANGED",
    };
};
