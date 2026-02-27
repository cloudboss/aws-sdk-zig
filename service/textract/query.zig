/// Each query contains the question you want to ask in the Text and the alias
/// you want to associate.
pub const Query = struct {
    /// Alias attached to the query, for ease of location.
    alias: ?[]const u8,

    /// Pages is a parameter that the user inputs to specify which pages to apply a
    /// query to. The following is a
    /// list of rules for using this parameter.
    ///
    /// * If a page is not specified, it is set to `["1"]` by default.
    ///
    /// * The following characters are allowed in the parameter's string:
    /// `0 1 2 3 4 5 6 7 8 9 - *`. No whitespace is allowed.
    ///
    /// * When using * to indicate all pages, it must be the only element in the
    ///   list.
    ///
    /// * You can use page intervals, such as `[“1-3”, “1-1”, “4-*”]`. Where `*`
    ///   indicates last page of
    /// document.
    ///
    /// * Specified pages must be greater than 0 and less than or equal to the
    ///   number of pages in the document.
    pages: ?[]const []const u8,

    /// Question that Amazon Textract will apply to the document. An example would
    /// be "What is the customer's SSN?"
    text: []const u8,

    pub const json_field_names = .{
        .alias = "Alias",
        .pages = "Pages",
        .text = "Text",
    };
};
