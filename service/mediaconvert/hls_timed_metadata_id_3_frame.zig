/// Specify the type of the ID3 frame to use for ID3 timestamps in your output.
/// To include ID3 timestamps: Specify PRIV or TDRL and set ID3 metadata to
/// Passthrough. To exclude ID3 timestamps: Set ID3 timestamp frame type to
/// None.
pub const HlsTimedMetadataId3Frame = enum {
    none,
    priv,
    tdrl,

    pub const json_field_names = .{
        .none = "NONE",
        .priv = "PRIV",
        .tdrl = "TDRL",
    };
};
