const UpdatedDescriptorSource = @import("updated_descriptor_source.zig").UpdatedDescriptorSource;

/// The set of AG-UI descriptor fields that can be individually updated.
pub const UpdatedAgUiDescriptorFields = struct {
    /// The patch for the descriptor's source field.
    source: ?UpdatedDescriptorSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
