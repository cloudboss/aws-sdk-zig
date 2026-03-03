/// Used to create a new message using only the specified attributes from the
/// original
/// message.
pub const SelectAttributesActivity = struct {
    /// A list of the attributes to select from the message.
    attributes: []const []const u8,

    /// The name of the `selectAttributes` activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .name = "name",
        .next = "next",
    };
};
