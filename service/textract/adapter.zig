/// An adapter selected for use when analyzing documents. Contains an adapter ID
/// and a version number.
/// Contains information on pages selected for analysis when analyzing documents
/// asychronously.
pub const Adapter = struct {
    /// A unique identifier for the adapter resource.
    adapter_id: []const u8,

    /// Pages is a parameter that the user inputs to specify which pages to apply an
    /// adapter to. The following is a
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
    /// * You can use page intervals, such as `["1-3", "1-1", "4-*"]`. Where `*`
    ///   indicates last page of
    /// document.
    ///
    /// * Specified pages must be greater than 0 and less than or equal to the
    ///   number of pages in the document.
    pages: ?[]const []const u8 = null,

    /// A string that identifies the version of the adapter.
    version: []const u8,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .pages = "Pages",
        .version = "Version",
    };
};
