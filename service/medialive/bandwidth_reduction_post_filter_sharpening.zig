/// Bandwidth Reduction Post Filter Sharpening
pub const BandwidthReductionPostFilterSharpening = enum {
    disabled,
    sharpening_1,
    sharpening_2,
    sharpening_3,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .sharpening_1 = "SHARPENING_1",
        .sharpening_2 = "SHARPENING_2",
        .sharpening_3 = "SHARPENING_3",
    };
};
