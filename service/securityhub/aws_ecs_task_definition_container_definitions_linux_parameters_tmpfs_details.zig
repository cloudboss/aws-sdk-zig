/// The container path, mount options, and size (in MiB) of a tmpfs mount.
pub const AwsEcsTaskDefinitionContainerDefinitionsLinuxParametersTmpfsDetails = struct {
    /// The absolute file path where the tmpfs volume is to be mounted.
    container_path: ?[]const u8 = null,

    /// The list of tmpfs volume mount options.
    ///
    /// Valid values: `"defaults"` | `"ro"` | `"rw"` | `"suid"` |
    /// `"nosuid"` | `"dev"` | `"nodev"` |` "exec"` |
    /// `"noexec"` | `"sync"` | `"async"` | `"dirsync"`
    /// | `"remount"` | `"mand"` | `"nomand"` | `"atime"`
    /// | `"noatime"` | `"diratime"` | `"nodiratime"` |
    /// `"bind"` | `"rbind"` | `"unbindable"` |
    /// `"runbindable"` | `"private"` | `"rprivate"` |
    /// `"shared"` | `"rshared"` | `"slave"` |
    /// `"rslave"` | `"relatime"` | `"norelatime"` |
    /// `"strictatime"` | `"nostrictatime"` |` "mode"` |
    /// `"uid"` | `"gid"` | `"nr_inodes"` |`
    /// "nr_blocks"` | `"mpol"`
    mount_options: ?[]const []const u8 = null,

    /// The maximum size (in MiB) of the tmpfs volume.
    size: ?i32 = null,

    pub const json_field_names = .{
        .container_path = "ContainerPath",
        .mount_options = "MountOptions",
        .size = "Size",
    };
};
