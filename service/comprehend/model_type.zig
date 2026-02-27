pub const ModelType = enum {
    document_classifier,
    entity_recognizer,

    pub const json_field_names = .{
        .document_classifier = "DOCUMENT_CLASSIFIER",
        .entity_recognizer = "ENTITY_RECOGNIZER",
    };
};
