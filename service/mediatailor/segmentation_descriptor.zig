/// The `segmentation_descriptor` message can contain advanced metadata fields,
/// like content identifiers, to convey a wide range of information about the ad
/// break. MediaTailor writes the ad metadata in the egress manifest as part of
/// the `EXT-X-DATERANGE` or `EventStream` ad marker's SCTE-35 data.
///
/// `segmentation_descriptor` messages must be sent with the `time_signal`
/// message type.
///
/// See the `segmentation_descriptor()` table of the 2022 SCTE-35 specification
/// for more information.
pub const SegmentationDescriptor = struct {
    /// The Event Identifier to assign to the
    /// `segmentation_descriptor.segmentation_event_id` message, as defined in
    /// section 10.3.3.1 of the 2022 SCTE-35 specification. The default value is 1.
    segmentation_event_id: ?i32 = null,

    /// The Type Identifier to assign to the
    /// `segmentation_descriptor.segmentation_type_id` message, as defined in
    /// section 10.3.3.1 of the 2022 SCTE-35 specification. Values must be between 0
    /// and 256, inclusive. The default value is 48.
    segmentation_type_id: ?i32 = null,

    /// The Upid to assign to the `segmentation_descriptor.segmentation_upid`
    /// message, as defined in section 10.3.3.1 of the 2022 SCTE-35 specification.
    /// The value must be a hexadecimal string containing only the characters 0
    /// though 9 and A through F. The default value is "" (an empty string).
    segmentation_upid: ?[]const u8 = null,

    /// The Upid Type to assign to the
    /// `segmentation_descriptor.segmentation_upid_type` message, as defined in
    /// section 10.3.3.1 of the 2022 SCTE-35 specification. Values must be between 0
    /// and 256, inclusive. The default value is 14.
    segmentation_upid_type: ?i32 = null,

    /// The segment number to assign to the `segmentation_descriptor.segment_num`
    /// message, as defined in section 10.3.3.1 of the 2022 SCTE-35 specification
    /// Values must be between 0 and 256, inclusive. The default value is 0.
    segment_num: ?i32 = null,

    /// The number of segments expected, which is assigned to the
    /// `segmentation_descriptor.segments_expectedS` message, as defined in section
    /// 10.3.3.1 of the 2022 SCTE-35 specification Values must be between 0 and 256,
    /// inclusive. The default value is 0.
    segments_expected: ?i32 = null,

    /// The sub-segment number to assign to the
    /// `segmentation_descriptor.sub_segment_num` message, as defined in section
    /// 10.3.3.1 of the 2022 SCTE-35 specification. Values must be between 0 and
    /// 256, inclusive. The defualt value is null.
    sub_segment_num: ?i32 = null,

    /// The number of sub-segments expected, which is assigned to the
    /// `segmentation_descriptor.sub_segments_expected` message, as defined in
    /// section 10.3.3.1 of the 2022 SCTE-35 specification. Values must be between 0
    /// and 256, inclusive. The default value is null.
    sub_segments_expected: ?i32 = null,

    pub const json_field_names = .{
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
