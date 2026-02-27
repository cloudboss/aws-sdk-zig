/// Contains information for a user identity in an access policy.
pub const UserIdentity = struct {
    /// The IAM Identity Center ID of the user.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
