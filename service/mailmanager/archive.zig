const ArchiveState = @import("archive_state.zig").ArchiveState;

/// An archive resource for storing and retaining emails.
pub const Archive = struct {
    /// The unique identifier of the archive.
    archive_id: []const u8,

    /// The unique name assigned to the archive.
    archive_name: ?[]const u8,

    /// The current state of the archive:
    ///
    /// * `ACTIVE` – The archive is ready and available for use.
    /// * `PENDING_DELETION` – The archive has been marked for deletion and will be
    ///   permanently deleted in 30 days. No further modifications can be made in
    ///   this state.
    archive_state: ?ArchiveState,

    /// The timestamp of when the archive was last updated.
    last_updated_timestamp: ?i64,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
        .archive_name = "ArchiveName",
        .archive_state = "ArchiveState",
        .last_updated_timestamp = "LastUpdatedTimestamp",
    };
};
