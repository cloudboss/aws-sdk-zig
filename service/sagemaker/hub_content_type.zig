pub const HubContentType = enum {
    model,
    notebook,
    model_reference,
    data_set,
    json_doc,

    pub const json_field_names = .{
        .model = "MODEL",
        .notebook = "NOTEBOOK",
        .model_reference = "MODEL_REFERENCE",
        .data_set = "DATA_SET",
        .json_doc = "JSON_DOC",
    };
};
