pub const InputFormat = enum {
    one_doc_per_file,
    one_doc_per_line,

    pub const json_field_names = .{
        .one_doc_per_file = "ONE_DOC_PER_FILE",
        .one_doc_per_line = "ONE_DOC_PER_LINE",
    };
};
