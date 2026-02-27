pub const DocumentClassifierDataFormat = enum {
    comprehend_csv,
    augmented_manifest,

    pub const json_field_names = .{
        .comprehend_csv = "COMPREHEND_CSV",
        .augmented_manifest = "AUGMENTED_MANIFEST",
    };
};
