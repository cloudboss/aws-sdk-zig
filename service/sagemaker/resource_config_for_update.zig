/// The `ResourceConfig` to update `KeepAlivePeriodInSeconds`. Other fields in
/// the `ResourceConfig` cannot be updated.
pub const ResourceConfigForUpdate = struct {
    /// The `KeepAlivePeriodInSeconds` value specified in the `ResourceConfig` to
    /// update.
    keep_alive_period_in_seconds: i32,

    pub const json_field_names = .{
        .keep_alive_period_in_seconds = "KeepAlivePeriodInSeconds",
    };
};
