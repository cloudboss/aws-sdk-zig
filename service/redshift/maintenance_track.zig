const UpdateTarget = @import("update_target.zig").UpdateTarget;

/// Defines a maintenance track that determines which Amazon Redshift version to
/// apply
/// during a maintenance window. If the value for `MaintenanceTrack` is
/// `current`, the cluster is updated to the most recently certified
/// maintenance release. If the value is `trailing`, the cluster is updated to
/// the previously certified maintenance release.
pub const MaintenanceTrack = struct {
    /// The version number for the cluster release.
    database_version: ?[]const u8 = null,

    /// The name of the maintenance track. Possible values are `current` and
    /// `trailing`.
    maintenance_track_name: ?[]const u8 = null,

    /// An array of UpdateTarget objects to update with the maintenance
    /// track.
    update_targets: ?[]const UpdateTarget = null,
};
