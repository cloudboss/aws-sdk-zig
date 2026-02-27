const FSxWindowsFileServerAuthorizationConfig = @import("f_sx_windows_file_server_authorization_config.zig").FSxWindowsFileServerAuthorizationConfig;

/// This parameter is specified when you're using [Amazon FSx for Windows File
/// Server](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/what-is.html)
/// file system for task storage.
///
/// For more information and the input format, see [Amazon FSx for Windows File
/// Server
/// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/wfsx-volumes.html) in the *Amazon Elastic Container Service Developer
/// Guide*.
pub const FSxWindowsFileServerVolumeConfiguration = struct {
    /// The authorization configuration details for the Amazon FSx for Windows File
    /// Server
    /// file system.
    authorization_config: FSxWindowsFileServerAuthorizationConfig,

    /// The Amazon FSx for Windows File Server file system ID to use.
    file_system_id: []const u8,

    /// The directory within the Amazon FSx for Windows File Server file system to
    /// mount as
    /// the root directory inside the host.
    root_directory: []const u8,

    pub const json_field_names = .{
        .authorization_config = "authorizationConfig",
        .file_system_id = "fileSystemId",
        .root_directory = "rootDirectory",
    };
};
