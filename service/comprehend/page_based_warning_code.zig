pub const PageBasedWarningCode = enum {
    inferencing_plaintext_with_native_trained_model,
    inferencing_native_document_with_plaintext_trained_model,

    pub const json_field_names = .{
        .inferencing_plaintext_with_native_trained_model = "INFERENCING_PLAINTEXT_WITH_NATIVE_TRAINED_MODEL",
        .inferencing_native_document_with_plaintext_trained_model = "INFERENCING_NATIVE_DOCUMENT_WITH_PLAINTEXT_TRAINED_MODEL",
    };
};
