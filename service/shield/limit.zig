/// Specifies how many protections of a given type you can create.
pub const Limit = struct {
    /// The maximum number of protections that can be created for the specified
    /// `Type`.
    max: i64 = 0,

    /// The type of protection.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .max = "Max",
        .@"type" = "Type",
    };
};
