/// A structure that contains details about a framework mapping, including the
/// framework name and specific item within the framework that the control maps
/// to.
pub const FrameworkMappingDetails = struct {
    /// The specific item or requirement within the framework that the control maps
    /// to.
    item: []const u8,

    /// The name of the compliance framework that the control maps to.
    name: []const u8,

    pub const json_field_names = .{
        .item = "Item",
        .name = "Name",
    };
};
