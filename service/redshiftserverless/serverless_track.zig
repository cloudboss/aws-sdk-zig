const UpdateTarget = @import("update_target.zig").UpdateTarget;

/// Defines a track that determines which Amazon Redshift version to apply after
/// a new version is released. If the value for `ServerlessTrack` is `current`,
/// the workgroup is updated to the most recently certified release. If the
/// value is `trailing`, the workgroup is updated to the previously certified
/// release.
pub const ServerlessTrack = struct {
    /// The name of the track. Valid values are `current` and `trailing`.
    track_name: ?[]const u8 = null,

    /// An array of `UpdateTarget` objects to update with the track.
    update_targets: ?[]const UpdateTarget = null,

    /// The workgroup version number for the workgroup release.
    workgroup_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .track_name = "trackName",
        .update_targets = "updateTargets",
        .workgroup_version = "workgroupVersion",
    };
};
