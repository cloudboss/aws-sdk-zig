/// Maps a batch delete document request to a specific data source sync job.
/// This is optional
/// and should only be supplied when documents are deleted by a data source
/// connector.
pub const DataSourceSyncJobMetrics = struct {
    /// The number of documents added from the data source up to now in the data
    /// source
    /// sync.
    documents_added: ?[]const u8 = null,

    /// The number of documents deleted from the data source up to now in the data
    /// source sync
    /// run.
    documents_deleted: ?[]const u8 = null,

    /// The number of documents that failed to sync from the data source up to now
    /// in the data
    /// source sync run.
    documents_failed: ?[]const u8 = null,

    /// The number of documents modified in the data source up to now in the data
    /// source sync
    /// run.
    documents_modified: ?[]const u8 = null,

    /// The current number of documents crawled by the current sync job in the data
    /// source.
    documents_scanned: ?[]const u8 = null,

    pub const json_field_names = .{
        .documents_added = "DocumentsAdded",
        .documents_deleted = "DocumentsDeleted",
        .documents_failed = "DocumentsFailed",
        .documents_modified = "DocumentsModified",
        .documents_scanned = "DocumentsScanned",
    };
};
