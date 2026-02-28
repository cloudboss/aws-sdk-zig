/// The phone number associated with the user.
pub const PhoneNumber = struct {
    /// A Boolean value representing whether this is the primary phone number for
    /// the associated resource.
    primary: bool = false,

    /// A string representing the type of a phone number. For example, "Mobile."
    @"type": ?[]const u8,

    /// A string containing a phone number. For example, "8675309" or "+1 (800)
    /// 123-4567".
    value: ?[]const u8,

    pub const json_field_names = .{
        .primary = "Primary",
        .@"type" = "Type",
        .value = "Value",
    };
};
