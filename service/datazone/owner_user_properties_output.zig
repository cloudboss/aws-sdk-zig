/// The properties of the owner user.
pub const OwnerUserPropertiesOutput = struct {
    /// The ID of the owner user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};
