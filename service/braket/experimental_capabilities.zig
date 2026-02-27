const ExperimentalCapabilitiesEnablementType = @import("experimental_capabilities_enablement_type.zig").ExperimentalCapabilitiesEnablementType;

/// Enabled experimental capabilities for quantum hardware. Note that the use of
/// these features may impact device capabilities and performance beyond its
/// standard specifications.
pub const ExperimentalCapabilities = union(enum) {
    /// Enabled experimental capabilities.
    enabled: ?ExperimentalCapabilitiesEnablementType,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
