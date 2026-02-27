const MissingDataTreatmentOption = @import("missing_data_treatment_option.zig").MissingDataTreatmentOption;

/// The configuration options that determine how missing data is treated during
/// the rendering of a line chart.
pub const MissingDataConfiguration = struct {
    /// The treatment option that determines how missing data should be rendered.
    /// Choose
    /// from the following options:
    ///
    /// * `INTERPOLATE`: Interpolate missing values between the prior and the next
    ///   known value.
    ///
    /// * `SHOW_AS_ZERO`: Show missing values as the value `0`.
    ///
    /// * `SHOW_AS_BLANK`: Display a blank space when rendering missing data.
    treatment_option: ?MissingDataTreatmentOption,

    pub const json_field_names = .{
        .treatment_option = "TreatmentOption",
    };
};
