/// Configuration properties for Hyperledger Fabric for a member in a Managed
/// Blockchain network that is using the Hyperledger Fabric framework.
pub const MemberFabricConfiguration = struct {
    /// The password for the member's initial administrative user. The
    /// `AdminPassword` must be at least 8 characters long and no more than 32
    /// characters. It must contain at least one uppercase letter, one lowercase
    /// letter, and one digit. It cannot have a single quotation mark (‘), a double
    /// quotation marks (“), a forward slash(/), a backward slash(\), @, or a space.
    admin_password: []const u8,

    /// The user name for the member's initial administrative user.
    admin_username: []const u8,

    pub const json_field_names = .{
        .admin_password = "AdminPassword",
        .admin_username = "AdminUsername",
    };
};
