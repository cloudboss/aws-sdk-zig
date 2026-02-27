/// A wrapper for pieces of the payload that's returned in response to a
/// streaming
/// inference request. A streaming inference response consists of one or more
/// payload parts.
pub const PayloadPart = struct {
    /// A blob that contains part of the response for your streaming inference
    /// request.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "Bytes",
    };
};
