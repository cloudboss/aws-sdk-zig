/// Describes an Active Directory.
pub const DirectoryServiceAuthentication = struct {
    /// The ID of the Active Directory used for authentication.
    directory_id: ?[]const u8,
};
