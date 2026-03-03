const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const MessageType = @import("message_type.zig").MessageType;
const SlateSource = @import("slate_source.zig").SlateSource;
const SpliceInsertMessage = @import("splice_insert_message.zig").SpliceInsertMessage;
const TimeSignalMessage = @import("time_signal_message.zig").TimeSignalMessage;

/// Ad break configuration parameters.
pub const AdBreak = struct {
    /// Defines a list of key/value pairs that MediaTailor generates within the
    /// `EXT-X-ASSET`tag for `SCTE35_ENHANCED` output.
    ad_break_metadata: ?[]const KeyValuePair = null,

    /// The SCTE-35 ad insertion type. Accepted value: `SPLICE_INSERT`,
    /// `TIME_SIGNAL`.
    message_type: ?MessageType = null,

    /// How long (in milliseconds) after the beginning of the program that an ad
    /// starts. This value must fall within 100ms of a segment boundary, otherwise
    /// the ad break will be skipped.
    offset_millis: i64 = 0,

    /// Ad break slate configuration.
    slate: ?SlateSource = null,

    /// This defines the SCTE-35 `splice_insert()` message inserted around the ad.
    /// For information about using `splice_insert()`, see the SCTE-35
    /// specficiaiton, section 9.7.3.1.
    splice_insert_message: ?SpliceInsertMessage = null,

    /// Defines the SCTE-35 `time_signal` message inserted around the ad.
    ///
    /// Programs on a channel's schedule can be configured with one or more ad
    /// breaks. You can attach a `splice_insert` SCTE-35 message to the ad break.
    /// This message provides basic metadata about the ad break.
    ///
    /// See section 9.7.4 of the 2022 SCTE-35 specification for more information.
    time_signal_message: ?TimeSignalMessage = null,

    pub const json_field_names = .{
        .ad_break_metadata = "AdBreakMetadata",
        .message_type = "MessageType",
        .offset_millis = "OffsetMillis",
        .slate = "Slate",
        .splice_insert_message = "SpliceInsertMessage",
        .time_signal_message = "TimeSignalMessage",
    };
};
