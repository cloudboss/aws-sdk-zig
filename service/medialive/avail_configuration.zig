const AvailSettings = @import("avail_settings.zig").AvailSettings;
const Scte35SegmentationScope = @import("scte_35_segmentation_scope.zig").Scte35SegmentationScope;

/// Avail Configuration
pub const AvailConfiguration = struct {
    /// Controls how SCTE-35 messages create cues. Splice Insert mode treats all
    /// segmentation signals traditionally. With Time Signal APOS mode only Time
    /// Signal Placement Opportunity and Break messages create segment breaks. With
    /// ESAM mode, signals are forwarded to an ESAM server for possible update.
    avail_settings: ?AvailSettings = null,

    /// Configures whether SCTE 35 passthrough triggers segment breaks in all output
    /// groups that use segmented outputs. Insertion of a SCTE 35 message typically
    /// results in a segment break, in addition to the regular cadence of breaks.
    /// The segment breaks appear in video outputs, audio outputs, and captions
    /// outputs (if any).
    ///
    /// ALL_OUTPUT_GROUPS: Default. Insert the segment break in in all output groups
    /// that have segmented outputs. This is the legacy behavior.
    /// SCTE35_ENABLED_OUTPUT_GROUPS: Insert the segment break only in output groups
    /// that have SCTE 35 passthrough enabled. This is the recommended value,
    /// because it reduces unnecessary segment breaks.
    scte_35_segmentation_scope: ?Scte35SegmentationScope = null,

    pub const json_field_names = .{
        .avail_settings = "AvailSettings",
        .scte_35_segmentation_scope = "Scte35SegmentationScope",
    };
};
