const HomeDirectoryMapEntry = @import("home_directory_map_entry.zig").HomeDirectoryMapEntry;
const HomeDirectoryType = @import("home_directory_type.zig").HomeDirectoryType;
const PosixProfile = @import("posix_profile.zig").PosixProfile;
const SshPublicKey = @import("ssh_public_key.zig").SshPublicKey;
const Tag = @import("tag.zig").Tag;

/// Describes the properties of a user that was specified.
pub const DescribedUser = struct {
    /// Specifies the unique Amazon Resource Name (ARN) for the user that was
    /// requested to be described.
    arn: []const u8,

    /// The landing directory (folder) for a user when they log in to the server
    /// using the client.
    ///
    /// A `HomeDirectory` example is `/bucket_name/home/mydirectory`.
    ///
    /// You can use the `HomeDirectory` parameter for `HomeDirectoryType` when it is
    /// set to either `PATH` or `LOGICAL`.
    home_directory: ?[]const u8 = null,

    /// Logical directory mappings that specify what Amazon S3 or Amazon EFS paths
    /// and keys should be visible to your user and how you want to make them
    /// visible. You must specify the `Entry` and `Target` pair, where `Entry` shows
    /// how the path is made visible and `Target` is the actual Amazon S3 or Amazon
    /// EFS path. If you only specify a target, it is displayed as is. You also must
    /// ensure that your Identity and Access Management (IAM) role provides access
    /// to paths in `Target`. This value can be set only when `HomeDirectoryType` is
    /// set to *LOGICAL*.
    ///
    /// In most cases, you can use this value instead of the session policy to lock
    /// your user down to the designated home directory ("`chroot`"). To do this,
    /// you can set `Entry` to '/' and set `Target` to the HomeDirectory parameter
    /// value.
    home_directory_mappings: ?[]const HomeDirectoryMapEntry = null,

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

    /// A session policy for your user so that you can use the same Identity and
    /// Access Management (IAM) role across multiple users. This policy scopes down
    /// a user's access to portions of their Amazon S3 bucket. Variables that you
    /// can use inside this policy include `${Transfer:UserName}`,
    /// `${Transfer:HomeDirectory}`, and `${Transfer:HomeBucket}`.
    policy: ?[]const u8 = null,

    /// Specifies the full POSIX identity, including user ID (`Uid`), group ID
    /// (`Gid`), and any secondary groups IDs (`SecondaryGids`), that controls your
    /// users' access to your Amazon Elastic File System (Amazon EFS) file systems.
    /// The POSIX permissions that are set on files and directories in your file
    /// system determine the level of access your users get when transferring files
    /// into and out of your Amazon EFS file systems.
    posix_profile: ?PosixProfile = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that controls your users' access to your Amazon S3 bucket or Amazon EFS
    /// file system. The policies attached to this role determine the level of
    /// access that you want to provide your users when transferring files into and
    /// out of your Amazon S3 bucket or Amazon EFS file system. The IAM role should
    /// also contain a trust relationship that allows the server to access your
    /// resources when servicing your users' transfer requests.
    role: ?[]const u8 = null,

    /// Specifies the public key portion of the Secure Shell (SSH) keys stored for
    /// the described user.
    ///
    /// To delete the public key body, set its value to zero keys, as shown here:
    ///
    /// `SshPublicKeys: []`
    ssh_public_keys: ?[]const SshPublicKey = null,

    /// Specifies the key-value pairs for the user requested. Tag can be used to
    /// search for and group users for a variety of purposes.
    tags: ?[]const Tag = null,

    /// Specifies the name of the user that was requested to be described. User
    /// names are used for authentication purposes. This is the string that will be
    /// used by your user when they log in to your server.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .home_directory = "HomeDirectory",
        .home_directory_mappings = "HomeDirectoryMappings",
        .home_directory_type = "HomeDirectoryType",
        .policy = "Policy",
        .posix_profile = "PosixProfile",
        .role = "Role",
        .ssh_public_keys = "SshPublicKeys",
        .tags = "Tags",
        .user_name = "UserName",
    };
};
