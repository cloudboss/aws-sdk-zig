/// To include key-length-value metadata in this output: Set KLV metadata
/// insertion to Passthrough. MediaConvert reads KLV metadata present in your
/// input and passes it through to the output transport stream. To exclude this
/// KLV metadata: Set KLV metadata insertion to None or leave blank.
pub const M2tsKlvMetadata = enum {
    passthrough,
    none,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
    };
};
