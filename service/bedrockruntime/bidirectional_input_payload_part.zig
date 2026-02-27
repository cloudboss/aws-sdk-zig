/// Payload content for the bidirectional input. The input is an audio stream.
pub const BidirectionalInputPayloadPart = struct {
    /// The audio content for the bidirectional input.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
    };
};
