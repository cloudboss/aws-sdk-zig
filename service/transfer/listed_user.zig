const HomeDirectoryType = @import("home_directory_type.zig").HomeDirectoryType;

/// Returns properties of the user that you specify.
pub const ListedUser = struct {
    /// Provides the unique Amazon Resource Name (ARN) for the user that you want to
    /// learn about.
    arn: []const u8,

    /// The landing directory (folder) for a user when they log in to the server
    /// using the client.
    ///
    /// A `HomeDirectory` example is `/bucket_name/home/mydirectory`.
    ///
    /// You can use the `HomeDirectory` parameter for `HomeDirectoryType` when it is
    /// set to either `PATH` or `LOGICAL`.
    home_directory: ?[]const u8 = null,

    /// The type of landing directory (folder) that you want your users' home
    /// directory to be when they log in to the server. If you set it to `PATH`, the
    /// user will see the absolute Amazon S3 bucket or Amazon EFS path as is in
    /// their file transfer protocol clients. If you set it to `LOGICAL`, you need
    /// to provide mappings in the `HomeDirectoryMappings` for how you want to make
    /// Amazon S3 or Amazon EFS paths visible to your users.
    ///
    /// If `HomeDirectoryType` is `LOGICAL`, you must provide mappings, using the
    /// `HomeDirectoryMappings` parameter. If, on the other hand,
    /// `HomeDirectoryType` is `PATH`, you provide an absolute path using the
    /// `HomeDirectory` parameter. You cannot have both `HomeDirectory` and
    /// `HomeDirectoryMappings` in your template.
    home_directory_type: ?HomeDirectoryType = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that controls your users' access to your Amazon S3 bucket or Amazon EFS
    /// file system. The policies attached to this role determine the level of
    /// access that you want to provide your users when transferring files into and
    /// out of your Amazon S3 bucket or Amazon EFS file system. The IAM role should
    /// also contain a trust relationship that allows the server to access your
    /// resources when servicing your users' transfer requests.
    ///
    /// The IAM role that controls your users' access to your Amazon S3 bucket for
    /// servers with `Domain=S3`, or your EFS file system for servers with
    /// `Domain=EFS`.
    ///
    /// The policies attached to this role determine the level of access you want to
    /// provide your users when transferring files into and out of your S3 buckets
    /// or EFS file systems.
    role: ?[]const u8 = null,

    /// Specifies the number of SSH public keys stored for the user you specified.
    ssh_public_key_count: ?i32 = null,

    /// Specifies the name of the user whose ARN was specified. User names are used
    /// for authentication purposes.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .home_directory = "HomeDirectory",
        .home_directory_type = "HomeDirectoryType",
        .role = "Role",
        .ssh_public_key_count = "SshPublicKeyCount",
        .user_name = "UserName",
    };
};
