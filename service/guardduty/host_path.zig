/// Represents a pre-existing file or directory on the host machine that the
/// volume maps to.
pub const HostPath = struct {
    /// Path of the file or directory on the host that the volume maps to.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .path = "Path",
    };
};
