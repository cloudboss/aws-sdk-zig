/// Specifies a monthly recurrence pattern for running a classification job.
pub const MonthlySchedule = struct {
    /// The numeric day of the month when Amazon Macie runs the job. This value can
    /// be an integer from 1 through 31.
    ///
    /// If this value exceeds the number of days in a certain month, Macie doesn't
    /// run the job that month. Macie runs the job only during months that have the
    /// specified day. For example, if this value is 31 and a month has only 30
    /// days, Macie doesn't run the job that month. To run the job every month,
    /// specify a value that's less than 29.
    day_of_month: ?i32 = null,

    pub const json_field_names = .{
        .day_of_month = "dayOfMonth",
    };
};
