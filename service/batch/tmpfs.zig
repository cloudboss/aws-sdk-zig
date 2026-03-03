/// The container path, mount options, and size of the `tmpfs` mount.
///
/// This object isn't applicable to jobs that are running on Fargate resources.
pub const Tmpfs = struct {
    /// The absolute file path in the container where the `tmpfs` volume is
    /// mounted.
    container_path: []const u8,

    /// The list of `tmpfs` volume mount options.
    ///
    /// Valid values: "`defaults`" | "`ro`" | "`rw`" |
    /// "`suid`" | "`nosuid`" | "`dev`" | "`nodev`" |
    /// "`exec`" | "`noexec`" | "`sync`" | "`async`" |
    /// "`dirsync`" | "`remount`" | "`mand`" | "`nomand`" |
    /// "`atime`" | "`noatime`" | "`diratime`" |
    /// "`nodiratime`" | "`bind`" | "`rbind" | "unbindable" | "runbindable" |
    /// "private" | "rprivate" | "shared" | "rshared" | "slave" | "rslave" |
    /// "relatime`" |
    /// "`norelatime`" | "`strictatime`" | "`nostrictatime`" |
    /// "`mode`" | "`uid`" | "`gid`" | "`nr_inodes`" |
    /// "`nr_blocks`" | "`mpol`"
    mount_options: ?[]const []const u8 = null,

    /// The size (in MiB) of the `tmpfs` volume.
    size: i32,

    pub const json_field_names = .{
        .container_path = "containerPath",
        .mount_options = "mountOptions",
        .size = "size",
    };
};
