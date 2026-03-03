/// Total number of scanned files.
pub const ScannedItemCount = struct {
    /// Number of files scanned.
    files: ?i32 = null,

    /// Total GB of files scanned for malware.
    total_gb: ?i32 = null,

    /// Total number of scanned volumes.
    volumes: ?i32 = null,

    pub const json_field_names = .{
        .files = "Files",
        .total_gb = "TotalGb",
        .volumes = "Volumes",
    };
};
