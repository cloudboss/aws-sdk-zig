/// Contains metadata about a User searched for within a collection.
pub const SearchedUser = struct {
    /// A provided ID for the UserID. Unique within the collection.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
