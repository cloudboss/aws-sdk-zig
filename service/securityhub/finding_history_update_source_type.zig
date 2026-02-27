pub const FindingHistoryUpdateSourceType = enum {
    batch_update_findings,
    batch_import_findings,

    pub const json_field_names = .{
        .batch_update_findings = "BATCH_UPDATE_FINDINGS",
        .batch_import_findings = "BATCH_IMPORT_FINDINGS",
    };
};
