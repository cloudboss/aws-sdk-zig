/// Corresponds to SCTE-35 segmentation_event_cancel_indicator.
/// SEGMENTATION_EVENT_NOT_CANCELED corresponds to 0 in the SCTE-35
/// specification and indicates that this is an insertion request.
/// SEGMENTATION_EVENT_CANCELED corresponds to 1 in the SCTE-35 specification
/// and indicates that this is a cancelation request, in which case complete
/// this field and the existing event ID to cancel.
pub const Scte35SegmentationCancelIndicator = enum {
    segmentation_event_not_canceled,
    segmentation_event_canceled,

    pub const json_field_names = .{
        .segmentation_event_not_canceled = "SEGMENTATION_EVENT_NOT_CANCELED",
        .segmentation_event_canceled = "SEGMENTATION_EVENT_CANCELED",
    };
};
