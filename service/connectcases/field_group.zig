const FieldItem = @import("field_item.zig").FieldItem;

/// Object for a group of fields and associated properties.
pub const FieldGroup = struct {
    /// Represents an ordered list containing field related information.
    fields: []const FieldItem,

    /// Name of the field group.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .fields = "fields",
        .name = "name",
    };
};
