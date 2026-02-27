/// The pagination configuration for a table visual or boxplot.
pub const PaginationConfiguration = struct {
    /// Indicates the page number.
    page_number: i64,

    /// Indicates how many items render in one page.
    page_size: i64,

    pub const json_field_names = .{
        .page_number = "PageNumber",
        .page_size = "PageSize",
    };
};
