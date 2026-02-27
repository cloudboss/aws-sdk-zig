const ParentChildFieldOptionsMapping = @import("parent_child_field_options_mapping.zig").ParentChildFieldOptionsMapping;

/// Rules that control which options are available in a child field based on the
/// selected value in a parent field.
pub const FieldOptionsCaseRule = struct {
    /// The identifier of the child field whose options are controlled.
    child_field_id: ?[]const u8,

    /// A mapping between a parent field option value and child field option values.
    parent_child_field_options_mappings: []const ParentChildFieldOptionsMapping,

    /// The identifier of the parent field that controls options.
    parent_field_id: ?[]const u8,

    pub const json_field_names = .{
        .child_field_id = "childFieldId",
        .parent_child_field_options_mappings = "parentChildFieldOptionsMappings",
        .parent_field_id = "parentFieldId",
    };
};
