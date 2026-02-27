const TranslationPinDataAs2805Format0 = @import("translation_pin_data_as_2805_format_0.zig").TranslationPinDataAs2805Format0;
const TranslationPinDataIsoFormat034 = @import("translation_pin_data_iso_format_034.zig").TranslationPinDataIsoFormat034;
const TranslationPinDataIsoFormat1 = @import("translation_pin_data_iso_format_1.zig").TranslationPinDataIsoFormat1;

/// Parameters that are required for translation between ISO9564 PIN block
/// formats 0,1,3,4.
pub const TranslationIsoFormats = union(enum) {
    /// Parameters that are required for AS2805 PIN format 0 translation.
    as_2805_format_0: ?TranslationPinDataAs2805Format0,
    /// Parameters that are required for ISO9564 PIN format 0 translation.
    iso_format_0: ?TranslationPinDataIsoFormat034,
    /// Parameters that are required for ISO9564 PIN format 1 translation.
    iso_format_1: ?TranslationPinDataIsoFormat1,
    /// Parameters that are required for ISO9564 PIN format 3 translation.
    iso_format_3: ?TranslationPinDataIsoFormat034,
    /// Parameters that are required for ISO9564 PIN format 4 translation.
    iso_format_4: ?TranslationPinDataIsoFormat034,

    pub const json_field_names = .{
        .as_2805_format_0 = "As2805Format0",
        .iso_format_0 = "IsoFormat0",
        .iso_format_1 = "IsoFormat1",
        .iso_format_3 = "IsoFormat3",
        .iso_format_4 = "IsoFormat4",
    };
};
