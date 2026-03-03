/// The email address associated with the user.
pub const Email = struct {
    /// A Boolean value representing whether this is the primary email address for
    /// the associated resource.
    primary: bool = false,

    /// A string representing the type of address. For example, "Work."
    @"type": ?[]const u8 = null,

    /// A string containing an email address. For example, "johndoe@amazon.com."
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .primary = "Primary",
        .@"type" = "Type",
        .value = "Value",
    };
};
