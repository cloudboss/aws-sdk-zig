/// A listing of an association with a channel configuration.
pub const AssociationListing = struct {
    /// The Amazon Resource Name (ARN) of the resource (for example, a custom
    /// action).
    resource: []const u8,

    pub const json_field_names = .{
        .resource = "Resource",
    };
};
