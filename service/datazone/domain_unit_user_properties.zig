/// The properties of the domain unit user.
pub const DomainUnitUserProperties = struct {
    /// The ID of teh domain unit user.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .user_id = "userId",
    };
};
