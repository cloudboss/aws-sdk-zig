/// To include ID3 metadata in this output: Set ID3 metadata to Passthrough.
/// Specify this ID3 metadata in Custom ID3 metadata inserter. MediaConvert
/// writes each instance of ID3 metadata in a separate Event Message (eMSG) box.
/// To exclude this ID3 metadata: Set ID3 metadata to None or leave blank.
pub const CmfcTimedMetadata = enum {
    passthrough,
    none,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
    };
};
