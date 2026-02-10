/// The minimum and maximum amount of total local storage, in GB.
pub const TotalLocalStorageGBRequest = struct {
    /// The maximum amount of total local storage, in GB. To specify no maximum
    /// limit, omit this
    /// parameter.
    max: ?f64,

    /// The minimum amount of total local storage, in GB. To specify no minimum
    /// limit, omit this
    /// parameter.
    min: ?f64,
};
