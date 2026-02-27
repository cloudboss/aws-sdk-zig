const ActiveDirectorySettings = @import("active_directory_settings.zig").ActiveDirectorySettings;
const ActiveDirectoryType = @import("active_directory_type.zig").ActiveDirectoryType;

/// Details about an Active Directory identity provider.
pub const ActiveDirectoryIdentityProvider = struct {
    /// The `ActiveDirectorySettings` resource contains details about the Active
    /// Directory, including network access details such as domain name and IP
    /// addresses, and the credential provider for user administration.
    active_directory_settings: ?ActiveDirectorySettings,

    /// The type of Active Directory – either a self-managed Active Directory or an
    /// Amazon Web Services Managed Active Directory.
    active_directory_type: ?ActiveDirectoryType,

    /// The directory ID for an Active Directory identity provider.
    directory_id: ?[]const u8,

    /// Whether this directory is shared from an Amazon Web Services Managed Active
    /// Directory. The default value is false.
    is_shared_active_directory: ?bool,

    pub const json_field_names = .{
        .active_directory_settings = "ActiveDirectorySettings",
        .active_directory_type = "ActiveDirectoryType",
        .directory_id = "DirectoryId",
        .is_shared_active_directory = "IsSharedActiveDirectory",
    };
};
