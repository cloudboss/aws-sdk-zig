const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .segmentation_event_not_canceled => "SEGMENTATION_EVENT_NOT_CANCELED",
            .segmentation_event_canceled => "SEGMENTATION_EVENT_CANCELED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
