/// Stores the holiday featurization attributes applicable to each item of
/// time-series datasets during the training of a forecasting model. This allows
/// the model to identify patterns associated with specific holidays.
pub const HolidayConfigAttributes = struct {
    /// The country code for the holiday calendar.
    ///
    /// For the list of public holiday calendars supported by AutoML job V2, see
    /// [Country
    /// Codes](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-timeseries-forecasting-holiday-calendars.html#holiday-country-codes). Use the country code corresponding to the country of your choice.
    country_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .country_code = "CountryCode",
    };
};
