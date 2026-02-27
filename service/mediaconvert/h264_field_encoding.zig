/// The video encoding method for your MPEG-4 AVC output. Keep the default
/// value, PAFF, to have MediaConvert use PAFF encoding for interlaced outputs.
/// Choose Force field to disable PAFF encoding and create separate interlaced
/// fields. Choose MBAFF to disable PAFF and have MediaConvert use MBAFF
/// encoding for interlaced outputs.
pub const H264FieldEncoding = enum {
    paff,
    force_field,
    mbaff,

    pub const json_field_names = .{
        .paff = "PAFF",
        .force_field = "FORCE_FIELD",
        .mbaff = "MBAFF",
    };
};
