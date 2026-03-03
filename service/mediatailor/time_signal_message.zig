const SegmentationDescriptor = @import("segmentation_descriptor.zig").SegmentationDescriptor;

/// The SCTE-35 `time_signal` message can be sent with one or more
/// `segmentation_descriptor` messages. A `time_signal` message can be sent only
/// if a single `segmentation_descriptor` message is sent.
///
/// The `time_signal` message contains only the `splice_time` field which is
/// constructed using a given presentation timestamp. When sending a
/// `time_signal` message, the `splice_command_type` field in the
/// `splice_info_section` message is set to 6 (0x06).
///
/// See the `time_signal()` table of the 2022 SCTE-35 specification for more
/// information.
pub const TimeSignalMessage = struct {
    /// The configurations for the SCTE-35 `segmentation_descriptor` message(s) sent
    /// with the `time_signal` message.
    segmentation_descriptors: ?[]const SegmentationDescriptor = null,

    pub const json_field_names = .{
        .segmentation_descriptors = "SegmentationDescriptors",
    };
};
