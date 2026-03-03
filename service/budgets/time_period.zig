/// The period of time that's covered by a budget. The period has a start date
/// and an end
/// date. The start date must come before the end date. There are no
/// restrictions on the end
/// date.
pub const TimePeriod = struct {
    /// The end date for a budget. If you didn't specify an end date, Amazon Web
    /// Services set
    /// your end date to `06/15/87 00:00 UTC`. The defaults are the same for the
    /// Billing and Cost Management console and the API.
    ///
    /// After the end date, Amazon Web Services deletes the budget and all the
    /// associated
    /// notifications and subscribers. You can change your end date with the
    /// `UpdateBudget` operation.
    end: ?i64 = null,

    /// The start date for a budget. If you created your budget and didn't specify a
    /// start
    /// date, Amazon Web Services defaults to the start of your chosen time period
    /// (DAILY,
    /// MONTHLY, QUARTERLY, ANNUALLY, or CUSTOM). For example, if you created your
    /// budget on January 24,
    /// 2018, chose `DAILY`, and didn't set a start date, Amazon Web Services set
    /// your
    /// start date to `01/24/18 00:00 UTC`. If you chose `MONTHLY`,
    /// Amazon Web Services set your start date to `01/01/18 00:00 UTC`. The
    /// defaults are the same for the Billing and Cost Management console and the
    /// API.
    ///
    /// You can change your start date with the `UpdateBudget` operation.
    start: ?i64 = null,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
