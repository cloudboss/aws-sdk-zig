/// Describes the Active Directory to be used for client authentication.
pub const DirectoryServiceAuthenticationRequest = struct {
    /// The ID of the Active Directory to be used for authentication.
    directory_id: ?[]const u8,
};
