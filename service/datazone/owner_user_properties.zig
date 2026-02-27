/// The properties of the owner user.
pub const OwnerUserProperties = struct {
    /// The ID of the owner user.
    user_identifier: []const u8,

    pub const json_field_names = .{
        .user_identifier = "userIdentifier",
    };
};
