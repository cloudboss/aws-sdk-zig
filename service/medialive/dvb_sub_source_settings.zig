const DvbSubOcrLanguage = @import("dvb_sub_ocr_language.zig").DvbSubOcrLanguage;

/// Dvb Sub Source Settings
pub const DvbSubSourceSettings = struct {
    /// If you will configure a WebVTT caption description that references this
    /// caption selector, use this field to
    /// provide the language to consider when translating the image-based source to
    /// text.
    ocr_language: ?DvbSubOcrLanguage,

    /// When using DVB-Sub with Burn-In or SMPTE-TT, use this PID for the source
    /// content. Unused for DVB-Sub passthrough. All DVB-Sub content is passed
    /// through, regardless of selectors.
    pid: ?i32,

    pub const json_field_names = .{
        .ocr_language = "OcrLanguage",
        .pid = "Pid",
    };
};
