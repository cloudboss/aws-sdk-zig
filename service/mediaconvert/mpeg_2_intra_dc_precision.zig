/// Use Intra DC precision to set quantization precision for intra-block DC
/// coefficients. If you choose the value auto, the service will automatically
/// select the precision based on the per-frame compression ratio.
pub const Mpeg2IntraDcPrecision = enum {
    auto,
    intra_dc_precision_8,
    intra_dc_precision_9,
    intra_dc_precision_10,
    intra_dc_precision_11,

    pub const json_field_names = .{
        .auto = "AUTO",
        .intra_dc_precision_8 = "INTRA_DC_PRECISION_8",
        .intra_dc_precision_9 = "INTRA_DC_PRECISION_9",
        .intra_dc_precision_10 = "INTRA_DC_PRECISION_10",
        .intra_dc_precision_11 = "INTRA_DC_PRECISION_11",
    };
};
