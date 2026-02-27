const FieldGroup = @import("field_group.zig").FieldGroup;

/// This represents a sections within a panel or tab of the page layout.
pub const Section = union(enum) {
    /// Consists of a group of fields and associated properties.
    field_group: ?FieldGroup,

    pub const json_field_names = .{
        .field_group = "fieldGroup",
    };
};
