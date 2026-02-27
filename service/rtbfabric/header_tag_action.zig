/// Describes the header tag for a bid action.
pub const HeaderTagAction = struct {
    /// The name of the bid action.
    name: []const u8,

    /// The value of the bid action.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
