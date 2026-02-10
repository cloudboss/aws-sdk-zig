/// The minimum and maximum amount of total local storage, in GB.
pub const TotalLocalStorageGB = struct {
    /// The maximum amount of total local storage, in GB. If this parameter is not
    /// specified, there is
    /// no maximum limit.
    max: ?f64,

    /// The minimum amount of total local storage, in GB. If this parameter is not
    /// specified, there is
    /// no minimum limit.
    min: ?f64,
};
