/// Represents the total (metered or unmetered) minutes used by the resource to
/// run
/// tests. Contains the sum of minutes consumed by all children.
pub const DeviceMinutes = struct {
    /// When specified, represents only the sum of metered minutes used by the
    /// resource to
    /// run tests.
    metered: ?f64,

    /// When specified, represents the total minutes used by the resource to run
    /// tests.
    total: ?f64,

    /// When specified, represents only the sum of unmetered minutes used by the
    /// resource
    /// to run tests.
    unmetered: ?f64,

    pub const json_field_names = .{
        .metered = "metered",
        .total = "total",
        .unmetered = "unmetered",
    };
};
