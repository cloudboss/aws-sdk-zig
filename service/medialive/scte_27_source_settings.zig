const Scte27OcrLanguage = @import("scte_27_ocr_language.zig").Scte27OcrLanguage;

/// Scte27 Source Settings
pub const Scte27SourceSettings = struct {
    /// If you will configure a WebVTT caption description that references this
    /// caption selector, use this field to
    /// provide the language to consider when translating the image-based source to
    /// text.
    ocr_language: ?Scte27OcrLanguage = null,

    /// The pid field is used in conjunction with the caption selector languageCode
    /// field as follows:
    /// - Specify PID and Language: Extracts captions from that PID; the language is
    /// "informational".
    /// - Specify PID and omit Language: Extracts the specified PID.
    /// - Omit PID and specify Language: Extracts the specified language, whichever
    /// PID that happens to be.
    /// - Omit PID and omit Language: Valid only if source is DVB-Sub that is being
    /// passed through; all languages will be passed through.
    pid: ?i32 = null,

    pub const json_field_names = .{
        .ocr_language = "OcrLanguage",
        .pid = "Pid",
    };
};
