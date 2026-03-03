/// The metadata transfer job's progress.
pub const MetadataTransferJobProgress = struct {
    /// The failed count.
    failed_count: ?i32 = null,

    /// The skipped count.
    skipped_count: ?i32 = null,

    /// The succeeded count.
    succeeded_count: ?i32 = null,

    /// The total count. [of what]
    total_count: ?i32 = null,

    pub const json_field_names = .{
        .failed_count = "failedCount",
        .skipped_count = "skippedCount",
        .succeeded_count = "succeededCount",
        .total_count = "totalCount",
    };
};
