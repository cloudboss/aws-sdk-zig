const DescriptorSource = @import("descriptor_source.zig").DescriptorSource;

/// A registry record descriptor for the AG-UI (Agent-User Interaction)
/// protocol.
pub const AgUiDescriptor = struct {
    source: ?DescriptorSource = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
