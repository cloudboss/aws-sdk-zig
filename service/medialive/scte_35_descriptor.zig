const Scte35DescriptorSettings = @import("scte_35_descriptor_settings.zig").Scte35DescriptorSettings;

/// Holds one set of SCTE-35 Descriptor Settings.
pub const Scte35Descriptor = struct {
    /// SCTE-35 Descriptor Settings.
    scte_35_descriptor_settings: Scte35DescriptorSettings,

    pub const json_field_names = .{
        .scte_35_descriptor_settings = "Scte35DescriptorSettings",
    };
};
