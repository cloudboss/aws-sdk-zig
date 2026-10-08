const UpdatedA2aAgentCardDescriptorFields = @import("updated_a2_a_agent_card_descriptor_fields.zig").UpdatedA2aAgentCardDescriptorFields;

/// The A2A agent card descriptor patch wrapper. Omit to leave the descriptor
/// unchanged; supply an empty object to remove it; supply optionalValue to
/// patch its fields.
pub const UpdatedA2aAgentCardDescriptor = struct {
    /// The value to set for this field. Omit the wrapper to leave the field
    /// unchanged.
    optional_value: ?UpdatedA2aAgentCardDescriptorFields = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
