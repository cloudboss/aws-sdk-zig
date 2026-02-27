const Scte35SegmentationDescriptor = @import("scte_35_segmentation_descriptor.zig").Scte35SegmentationDescriptor;

/// SCTE-35 Descriptor settings.
pub const Scte35DescriptorSettings = struct {
    /// SCTE-35 Segmentation Descriptor.
    segmentation_descriptor_scte_35_descriptor_settings: Scte35SegmentationDescriptor,

    pub const json_field_names = .{
        .segmentation_descriptor_scte_35_descriptor_settings = "SegmentationDescriptorScte35DescriptorSettings",
    };
};
