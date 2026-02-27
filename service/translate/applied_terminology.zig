const Term = @import("term.zig").Term;

/// The custom terminology applied to the input text by Amazon Translate for the
/// translated text
/// response. This is optional in the response and will only be present if you
/// specified
/// terminology input in the request. Currently, only one terminology can be
/// applied per
/// TranslateText request.
pub const AppliedTerminology = struct {
    /// The name of the custom terminology applied to the input text by Amazon
    /// Translate for the translated
    /// text response.
    name: ?[]const u8,

    /// The specific terms of the custom terminology applied to the input text by
    /// Amazon Translate for the
    /// translated text response. A maximum of 250 terms will be returned, and the
    /// specific terms
    /// applied will be the first 250 terms in the source text.
    terms: ?[]const Term,

    pub const json_field_names = .{
        .name = "Name",
        .terms = "Terms",
    };
};
