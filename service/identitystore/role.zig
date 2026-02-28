/// The role associated with the user.
pub const Role = struct {
    /// A Boolean value representing whether this is the primary role for the
    /// associated resource.
    primary: bool = false,

    /// A string representing the type of role. For example, "Work."
    @"type": ?[]const u8,

    /// A string containing a role name. For example, "Researcher."
    value: ?[]const u8,

    pub const json_field_names = .{
        .primary = "Primary",
        .@"type" = "Type",
        .value = "Value",
    };
};
