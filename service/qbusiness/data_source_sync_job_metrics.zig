/// Maps a batch delete document request to a specific Amazon Q Business data
/// source connector sync job.
pub const DataSourceSyncJobMetrics = struct {
    /// The current count of documents added from the data source during the data
    /// source sync.
    documents_added: ?[]const u8 = null,

    /// The current count of documents deleted from the data source during the data
    /// source sync.
    documents_deleted: ?[]const u8 = null,

    /// The current count of documents that failed to sync from the data source
    /// during the data source sync.
    documents_failed: ?[]const u8 = null,

    /// The current count of documents modified in the data source during the data
    /// source sync.
    documents_modified: ?[]const u8 = null,

    /// The current count of documents crawled by the ongoing sync job in the data
    /// source.
    documents_scanned: ?[]const u8 = null,

    pub const json_field_names = .{
        .documents_added = "documentsAdded",
        .documents_deleted = "documentsDeleted",
        .documents_failed = "documentsFailed",
        .documents_modified = "documentsModified",
        .documents_scanned = "documentsScanned",
    };
};
