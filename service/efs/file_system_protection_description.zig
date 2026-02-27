const ReplicationOverwriteProtection = @import("replication_overwrite_protection.zig").ReplicationOverwriteProtection;

/// Describes the protection on a file system.
pub const FileSystemProtectionDescription = struct {
    /// The status of the file system's replication overwrite protection.
    ///
    /// * `ENABLED` – The file system cannot be used as the destination file
    /// system in a replication configuration. The file system is writeable.
    /// Replication overwrite
    /// protection is `ENABLED` by default.
    ///
    /// * `DISABLED` – The file system can be used as the destination file
    /// system in a replication configuration. The file system is read-only and can
    /// only be
    /// modified by EFS replication.
    ///
    /// * `REPLICATING` – The file system is being used as the destination
    /// file system in a replication configuration. The file system is read-only and
    /// is modified
    /// only by EFS replication.
    ///
    /// If the replication configuration is deleted, the file system's replication
    /// overwrite
    /// protection is re-enabled, the file system becomes writeable.
    replication_overwrite_protection: ?ReplicationOverwriteProtection,

    pub const json_field_names = .{
        .replication_overwrite_protection = "ReplicationOverwriteProtection",
    };
};
