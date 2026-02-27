pub const PageBasedErrorCode = enum {
    textract_bad_page,
    textract_provisioned_throughput_exceeded,
    page_characters_exceeded,
    page_size_exceeded,
    internal_server_error,

    pub const json_field_names = .{
        .textract_bad_page = "TEXTRACT_BAD_PAGE",
        .textract_provisioned_throughput_exceeded = "TEXTRACT_PROVISIONED_THROUGHPUT_EXCEEDED",
        .page_characters_exceeded = "PAGE_CHARACTERS_EXCEEDED",
        .page_size_exceeded = "PAGE_SIZE_EXCEEDED",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
