/// Use this setting only when you specify SCTE-35 markers from ESAM. Choose
/// INSERT to put SCTE-35 markers in this output at the insertion points that
/// you specify in an ESAM XML document. Provide the document in the setting SCC
/// XML.
pub const CmfcScte35Esam = enum {
    insert,
    none,

    pub const json_field_names = .{
        .insert = "INSERT",
        .none = "NONE",
    };
};
