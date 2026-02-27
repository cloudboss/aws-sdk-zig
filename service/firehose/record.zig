/// The unit of data in a Firehose stream.
pub const Record = struct {
    /// The data blob, which is base64-encoded when the blob is serialized. The
    /// maximum size
    /// of the data blob, before base64-encoding, is 1,000 KiB.
    data: []const u8,

    pub const json_field_names = .{
        .data = "Data",
    };
};
