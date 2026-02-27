/// The metadata transfer job's progress.
pub const MetadataTransferJobProgress = struct {
    /// The failed count.
    failed_count: ?i32,

    /// The skipped count.
    skipped_count: ?i32,

    /// The succeeded count.
    succeeded_count: ?i32,

    /// The total count. [of what]
    total_count: ?i32,

    pub const json_field_names = .{
        .failed_count = "failedCount",
        .skipped_count = "skippedCount",
        .succeeded_count = "succeededCount",
        .total_count = "totalCount",
    };
};
