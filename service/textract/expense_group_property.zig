/// Shows the group that a certain key belongs to. This helps differentiate
/// between
/// names and addresses for different organizations, that can be hard to
/// determine
/// via JSON response.
pub const ExpenseGroupProperty = struct {
    /// Provides a group Id number, which will be the same for each in the group.
    id: ?[]const u8 = null,

    /// Informs you on whether the expense group is a name or an address.
    types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .types = "Types",
    };
};
