const DocumentClassificationConfig = @import("document_classification_config.zig").DocumentClassificationConfig;
const EntityRecognitionConfig = @import("entity_recognition_config.zig").EntityRecognitionConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;

/// Configuration about the model associated with a flywheel.
pub const TaskConfig = struct {
    /// Configuration required for a document classification model.
    document_classification_config: ?DocumentClassificationConfig = null,

    /// Configuration required for an entity recognition model.
    entity_recognition_config: ?EntityRecognitionConfig = null,

    /// Language code for the language that the model supports.
    language_code: LanguageCode,

    pub const json_field_names = .{
        .document_classification_config = "DocumentClassificationConfig",
        .entity_recognition_config = "EntityRecognitionConfig",
        .language_code = "LanguageCode",
    };
};
