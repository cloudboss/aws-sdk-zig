/// Specifies who can mount an OpenZFS file system and the options available
/// while
/// mounting the file system.
pub const OpenZFSClientConfiguration = struct {
    /// A value that specifies who can mount the file system. You can provide a
    /// wildcard
    /// character (`*`), an IP address (`0.0.0.0`), or a CIDR address
    /// (`192.0.2.0/24`). By default, Amazon FSx uses the wildcard
    /// character when specifying the client.
    clients: []const u8,

    /// The options to use when mounting the file system. For a list of options that
    /// you can
    /// use with Network File System (NFS), see the [exports(5) - Linux man
    /// page](https://linux.die.net/man/5/exports). When
    /// choosing your options, consider the following:
    ///
    /// * `crossmnt` is used by default. If you don't specify
    /// `crossmnt` when changing the client configuration, you won't be
    /// able to see or access snapshots in your file system's snapshot directory.
    ///
    /// * `sync` is used by default. If you instead specify
    /// `async`, the system acknowledges writes before writing to disk.
    /// If the system crashes before the writes are finished, you lose the unwritten
    /// data.
    options: []const []const u8,

    pub const json_field_names = .{
        .clients = "Clients",
        .options = "Options",
    };
};
