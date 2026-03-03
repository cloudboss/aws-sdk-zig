/// Contains information about access-based benefit fulfillment, such as service
/// permissions or feature access.
pub const AccessDetails = struct {
    /// A description of the access privileges or permissions granted by this
    /// benefit.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
    };
};
