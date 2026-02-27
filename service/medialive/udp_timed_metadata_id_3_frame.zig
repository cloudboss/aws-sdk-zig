/// Udp Timed Metadata Id3 Frame
pub const UdpTimedMetadataId3Frame = enum {
    none,
    priv,
    tdrl,

    pub const json_field_names = .{
        .none = "NONE",
        .priv = "PRIV",
        .tdrl = "TDRL",
    };
};
