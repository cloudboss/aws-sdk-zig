const Scte35DeliveryRestrictions = @import("scte_35_delivery_restrictions.zig").Scte35DeliveryRestrictions;
const Scte35SegmentationCancelIndicator = @import("scte_35_segmentation_cancel_indicator.zig").Scte35SegmentationCancelIndicator;

/// Corresponds to SCTE-35 segmentation_descriptor.
pub const Scte35SegmentationDescriptor = struct {
    /// Holds the four SCTE-35 delivery restriction parameters.
    delivery_restrictions: ?Scte35DeliveryRestrictions = null,

    /// Corresponds to SCTE-35 segmentation_event_cancel_indicator.
    segmentation_cancel_indicator: Scte35SegmentationCancelIndicator,

    /// Corresponds to SCTE-35 segmentation_duration. Optional. The duration for the
    /// time_signal, in 90 KHz ticks. To convert seconds to ticks, multiple the
    /// seconds by 90,000. Enter time in 90 KHz clock ticks. If you do not enter a
    /// duration, the time_signal will continue until you insert a cancellation
    /// message.
    segmentation_duration: ?i64 = null,

    /// Corresponds to SCTE-35 segmentation_event_id.
    segmentation_event_id: i64,

    /// Corresponds to SCTE-35 segmentation_type_id. One of the segmentation_type_id
    /// values listed in the SCTE-35 specification. On the console, enter the ID in
    /// decimal (for example, "52"). In the CLI, API, or an SDK, enter the ID in hex
    /// (for example, "0x34") or decimal (for example, "52").
    segmentation_type_id: ?i32 = null,

    /// Corresponds to SCTE-35 segmentation_upid. Enter a string containing the
    /// hexadecimal representation of the characters that make up the SCTE-35
    /// segmentation_upid value. Must contain an even number of hex characters. Do
    /// not include spaces between each hex pair. For example, the ASCII "ADS
    /// Information" becomes hex "41445320496e666f726d6174696f6e.
    segmentation_upid: ?[]const u8 = null,

    /// Corresponds to SCTE-35 segmentation_upid_type. On the console, enter one of
    /// the types listed in the SCTE-35 specification, converted to a decimal. For
    /// example, "0x0C" hex from the specification is "12" in decimal. In the CLI,
    /// API, or an SDK, enter one of the types listed in the SCTE-35 specification,
    /// in either hex (for example, "0x0C" ) or in decimal (for example, "12").
    segmentation_upid_type: ?i32 = null,

    /// Corresponds to SCTE-35 segment_num. A value that is valid for the specified
    /// segmentation_type_id.
    segment_num: ?i32 = null,

    /// Corresponds to SCTE-35 segments_expected. A value that is valid for the
    /// specified segmentation_type_id.
    segments_expected: ?i32 = null,

    /// Corresponds to SCTE-35 sub_segment_num. A value that is valid for the
    /// specified segmentation_type_id.
    sub_segment_num: ?i32 = null,

    /// Corresponds to SCTE-35 sub_segments_expected. A value that is valid for the
    /// specified segmentation_type_id.
    sub_segments_expected: ?i32 = null,

    pub const json_field_names = .{
        .delivery_restrictions = "DeliveryRestrictions",
        .segmentation_cancel_indicator = "SegmentationCancelIndicator",
        .segmentation_duration = "SegmentationDuration",
        .segmentation_event_id = "SegmentationEventId",
        .segmentation_type_id = "SegmentationTypeId",
        .segmentation_upid = "SegmentationUpid",
        .segmentation_upid_type = "SegmentationUpidType",
        .segment_num = "SegmentNum",
        .segments_expected = "SegmentsExpected",
        .sub_segment_num = "SubSegmentNum",
        .sub_segments_expected = "SubSegmentsExpected",
    };
};
