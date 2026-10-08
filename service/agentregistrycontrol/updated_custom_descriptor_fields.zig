const UpdatedDescriptorData = @import("updated_descriptor_data.zig").UpdatedDescriptorData;

/// The set of custom descriptor fields that can be individually updated.
pub const UpdatedCustomDescriptorFields = struct {
    /// The patch for the descriptor's data field.
    data: ?UpdatedDescriptorData = null,

    pub const json_field_names = .{
        .data = "data",
    };
};
