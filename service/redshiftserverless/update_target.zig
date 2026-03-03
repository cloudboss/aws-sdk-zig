/// A track that you can switch the current track to.
pub const UpdateTarget = struct {
    /// The name of the new track.
    track_name: ?[]const u8 = null,

    /// The workgroup version for the new track.
    workgroup_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .track_name = "trackName",
        .workgroup_version = "workgroupVersion",
    };
};
