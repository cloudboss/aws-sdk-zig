/// The instance details to specify which volumes should be snapshotted.
pub const InstanceSpecification = struct {
    /// Excludes the root volume from being snapshotted.
    exclude_boot_volume: ?bool,

    /// The IDs of the data (non-root) volumes to exclude from the multi-volume
    /// snapshot set.
    /// If you specify the ID of the root volume, the request fails. To exclude the
    /// root volume,
    /// use **ExcludeBootVolume**.
    ///
    /// You can specify up to 40 volume IDs per request.
    exclude_data_volume_ids: ?[]const []const u8,

    /// The instance to specify which volumes should be snapshotted.
    instance_id: []const u8,
};
