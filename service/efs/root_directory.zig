const CreationInfo = @import("creation_info.zig").CreationInfo;

/// Specifies the directory on the Amazon EFS file system that the access point
/// provides access to. The access point exposes the specified file system path
/// as the root
/// directory of your file system to applications using the access point. NFS
/// clients using the
/// access point can only access data in the access point's `RootDirectory` and
/// its
/// subdirectories.
pub const RootDirectory = struct {
    /// (Optional) Specifies the POSIX IDs and permissions to apply to the access
    /// point's
    /// `RootDirectory`. If the `RootDirectory` > `Path`
    /// specified does not exist, EFS creates the root directory using the
    /// `CreationInfo` settings when a client connects to an access point. When
    /// specifying the `CreationInfo`, you must provide values for all properties.
    ///
    /// If you do not provide `CreationInfo` and the specified `RootDirectory` >
    /// `Path` does not exist,
    /// attempts to mount the file system using the access point will fail.
    creation_info: ?CreationInfo,

    /// Specifies the path on the EFS file system to expose as the root directory to
    /// NFS clients using the access point to access the EFS file system. A path can
    /// have
    /// up to four subdirectories. If the specified path does not exist, you are
    /// required to provide
    /// the `CreationInfo`.
    path: ?[]const u8,

    pub const json_field_names = .{
        .creation_info = "CreationInfo",
        .path = "Path",
    };
};
