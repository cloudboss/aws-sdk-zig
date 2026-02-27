/// Security profile items.
pub const SecurityProfileItem = struct {
    /// Id of a security profile item.
    id: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
