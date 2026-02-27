pub const AwsManagedHumanLoopRequestSource = enum {
    rekognition_detect_moderation_labels_image_v3,
    textract_analyze_document_forms_v1,

    pub const json_field_names = .{
        .rekognition_detect_moderation_labels_image_v3 = "REKOGNITION_DETECT_MODERATION_LABELS_IMAGE_V3",
        .textract_analyze_document_forms_v1 = "TEXTRACT_ANALYZE_DOCUMENT_FORMS_V1",
    };
};
