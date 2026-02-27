pub const ContentClassifier = enum {
    free_of_personally_identifiable_information,
    free_of_adult_content,

    pub const json_field_names = .{
        .free_of_personally_identifiable_information = "FREE_OF_PERSONALLY_IDENTIFIABLE_INFORMATION",
        .free_of_adult_content = "FREE_OF_ADULT_CONTENT",
    };
};
