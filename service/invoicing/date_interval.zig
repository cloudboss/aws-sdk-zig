/// The time period that you want invoice-related documents for.
pub const DateInterval = struct {
    /// The end of the time period that you want invoice-related documents for. The
    /// end date is exclusive. For example, if `end` is `2019-01-10`, Amazon Web
    /// Services retrieves invoice-related documents from the start date up to, but
    /// not including, `2018-01-10`.
    end_date: i64,

    /// The beginning of the time period that you want invoice-related documents
    /// for. The start date is inclusive. For example, if `start` is `2019-01-01`,
    /// AWS retrieves invoices starting at `2019-01-01` up to the end date.
    start_date: i64,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .start_date = "StartDate",
    };
};
