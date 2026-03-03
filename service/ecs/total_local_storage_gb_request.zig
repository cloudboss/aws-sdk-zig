/// The minimum and maximum total local storage in gigabytes (GB) for instance
/// types with
/// local storage. This is useful for workloads that require local storage for
/// temporary
/// data or caching.
pub const TotalLocalStorageGBRequest = struct {
    /// The maximum total local storage in GB. Instance types with more local
    /// storage are
    /// excluded from selection.
    max: ?f64 = null,

    /// The minimum total local storage in GB. Instance types with less local
    /// storage are
    /// excluded from selection.
    min: ?f64 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
