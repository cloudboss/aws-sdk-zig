/// The number of days your data is kept in the hot tier. By default, your data
/// is kept indefinitely in the hot tier.
pub const RetentionPeriod = struct {
    /// The number of days that your data is kept.
    ///
    /// If you specified a value for this parameter, the `unlimited` parameter must
    /// be `false`.
    number_of_days: ?i32 = null,

    /// If true, your data is kept indefinitely.
    ///
    /// If configured to `true`, you must not specify a value for the
    /// `numberOfDays` parameter.
    unlimited: ?bool = null,

    pub const json_field_names = .{
        .number_of_days = "numberOfDays",
        .unlimited = "unlimited",
    };
};
