const PosixUser = @import("posix_user.zig").PosixUser;
const RootDirectory = @import("root_directory.zig").RootDirectory;
const Tag = @import("tag.zig").Tag;

pub const CreateAccessPointRequest = struct {
    /// A string of up to 64 ASCII characters that Amazon EFS uses to ensure
    /// idempotent
    /// creation.
    client_token: []const u8,

    /// The ID of the EFS file system that the access point provides access to.
    file_system_id: []const u8,

    /// The operating system user and
    /// group applied to all file system requests made using the access point.
    posix_user: ?PosixUser = null,

    /// Specifies the directory on the EFS file system that the access point exposes
    /// as
    /// the root directory of your file system to NFS clients using the access
    /// point. The clients
    /// using the access point can only access the root directory and below. If the
    /// `RootDirectory` > `Path` specified does not exist, Amazon EFS creates it and
    /// applies the `CreationInfo` settings when a client connects to an
    /// access point. When specifying a `RootDirectory`, you must provide the
    /// `Path`, and the `CreationInfo`.
    ///
    /// Amazon EFS creates a root directory only if you have provided the
    /// CreationInfo: OwnUid, OwnGID, and permissions for the directory.
    /// If you do not provide this information, Amazon EFS does not create the root
    /// directory. If the root directory does not exist, attempts to mount
    /// using the access point will fail.
    root_directory: ?RootDirectory = null,

    /// Creates tags associated with the access point. Each tag is a key-value pair,
    /// each key must be unique. For more
    /// information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .file_system_id = "FileSystemId",
        .posix_user = "PosixUser",
        .root_directory = "RootDirectory",
        .tags = "Tags",
    };
};
