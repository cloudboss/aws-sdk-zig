/// An activity that removes attributes from a message.
pub const RemoveAttributesActivity = struct {
    /// A list of 1-50 attributes to remove from the message.
    attributes: []const []const u8,

    /// The name of the `removeAttributes` activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .name = "name",
        .next = "next",
    };
};
