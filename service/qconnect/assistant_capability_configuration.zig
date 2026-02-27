const AssistantCapabilityType = @import("assistant_capability_type.zig").AssistantCapabilityType;

/// The capability configuration for an Amazon Q in Connect assistant.
pub const AssistantCapabilityConfiguration = struct {
    /// The type of Amazon Q in Connect assistant capability.
    type: ?AssistantCapabilityType,

    pub const json_field_names = .{
        .type = "type",
    };
};
