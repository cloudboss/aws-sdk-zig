/// An alias for an edge.
pub const Alias = struct {
    /// The canonical name of the alias.
    name: ?[]const u8 = null,

    /// A list of names for the alias, including the canonical name.
    names: ?[]const []const u8 = null,

    /// The type of the alias.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .names = "Names",
        .@"type" = "Type",
    };
};
