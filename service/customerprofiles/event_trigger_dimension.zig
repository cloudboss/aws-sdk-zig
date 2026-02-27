const ObjectAttribute = @import("object_attribute.zig").ObjectAttribute;

/// A specific event dimension to be assessed.
pub const EventTriggerDimension = struct {
    /// A list of object attributes to be evaluated.
    object_attributes: []const ObjectAttribute,

    pub const json_field_names = .{
        .object_attributes = "ObjectAttributes",
    };
};
