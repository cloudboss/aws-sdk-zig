const TranscribeMedicalContentIdentificationType = @import("transcribe_medical_content_identification_type.zig").TranscribeMedicalContentIdentificationType;
const TranscribeMedicalLanguageCode = @import("transcribe_medical_language_code.zig").TranscribeMedicalLanguageCode;
const TranscribeMedicalRegion = @import("transcribe_medical_region.zig").TranscribeMedicalRegion;
const TranscribeMedicalSpecialty = @import("transcribe_medical_specialty.zig").TranscribeMedicalSpecialty;
const TranscribeMedicalType = @import("transcribe_medical_type.zig").TranscribeMedicalType;

/// Settings specific to the Amazon Transcribe Medical engine.
pub const EngineTranscribeMedicalSettings = struct {
    /// Set this field to `PHI` to identify personal health information in the
    /// transcription output.
    content_identification_type: ?TranscribeMedicalContentIdentificationType = null,

    /// The language code specified for the Amazon Transcribe Medical engine.
    language_code: TranscribeMedicalLanguageCode,

    /// The Amazon Web Services Region passed to Amazon Transcribe Medical. If you
    /// don't specify a Region, Amazon Chime uses the meeting's Region.
    region: ?TranscribeMedicalRegion = null,

    /// The specialty specified for the Amazon Transcribe Medical engine.
    specialty: TranscribeMedicalSpecialty,

    /// The type of transcription.
    @"type": TranscribeMedicalType,

    /// The name of the vocabulary passed to Amazon Transcribe Medical.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_identification_type = "ContentIdentificationType",
        .language_code = "LanguageCode",
        .region = "Region",
        .specialty = "Specialty",
        .@"type" = "Type",
        .vocabulary_name = "VocabularyName",
    };
};
