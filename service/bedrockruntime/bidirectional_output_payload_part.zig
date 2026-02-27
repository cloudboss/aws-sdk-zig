/// Output from the bidirectional stream. The output is speech and a text
/// transcription.
pub const BidirectionalOutputPayloadPart = struct {
    /// The speech output of the bidirectional stream.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
    };
};
