const HomeDirectoryType = @import("home_directory_type.zig").HomeDirectoryType;

/// Lists the properties for one or more specified associated accesses.
pub const ListedAccess = struct {
    /// A unique identifier that is required to identify specific groups within your
    /// directory. The users of the group that you associate have access to your
    /// Amazon S3 or Amazon EFS resources over the enabled protocols using Transfer
    /// Family. If you know the group name, you can view the SID values by running
    /// the following command using Windows PowerShell.
    ///
    /// `Get-ADGroup -Filter {samAccountName -like "*YourGroupName**"} -Properties *
    /// | Select SamAccountName,ObjectSid`
    ///
    /// In that command, replace *YourGroupName* with the name of your Active
    /// Directory group.
    ///
    /// The regular expression used to validate this parameter is a string of
    /// characters consisting of uppercase and lowercase alphanumeric characters
    /// with no spaces. You can also include underscores or any of the following
    /// characters: =,.@:/-
    external_id: ?[]const u8 = null,

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
    role: ?[]const u8 = null,

    pub const json_field_names = .{
        .external_id = "ExternalId",
        .home_directory = "HomeDirectory",
        .home_directory_type = "HomeDirectoryType",
        .role = "Role",
    };
};
