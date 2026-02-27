/// Describes the user volume for a WorkSpace bundle.
pub const UserStorage = struct {
    /// The size of the user volume.
    capacity: []const u8,

    pub const json_field_names = .{
        .capacity = "Capacity",
    };
};
