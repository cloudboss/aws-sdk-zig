pub const EbsSnapshotPreservation = enum {
    no_retention,
    retention_with_finding,

    pub const json_field_names = .{
        .no_retention = "NO_RETENTION",
        .retention_with_finding = "RETENTION_WITH_FINDING",
    };
};
