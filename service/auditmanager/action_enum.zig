pub const ActionEnum = enum {
    create,
    update_metadata,
    active,
    inactive,
    delete,
    under_review,
    reviewed,
    import_evidence,

    pub const json_field_names = .{
        .create = "CREATE",
        .update_metadata = "UPDATE_METADATA",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .delete = "DELETE",
        .under_review = "UNDER_REVIEW",
        .reviewed = "REVIEWED",
        .import_evidence = "IMPORT_EVIDENCE",
    };
};
