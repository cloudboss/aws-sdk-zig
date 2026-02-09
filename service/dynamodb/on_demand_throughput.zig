/// Sets the maximum number of read and write units for the specified on-demand
/// table. If
/// you use this parameter, you must specify `MaxReadRequestUnits`,
/// `MaxWriteRequestUnits`, or both.
pub const OnDemandThroughput = struct {
    /// Maximum number of read request units for the specified table.
    ///
    /// To specify a maximum `OnDemandThroughput` on your table, set the value of
    /// `MaxReadRequestUnits` as greater than or equal to 1. To remove the
    /// maximum `OnDemandThroughput` that is currently set on your table, set the
    /// value of `MaxReadRequestUnits` to -1.
    max_read_request_units: ?i64,

    /// Maximum number of write request units for the specified table.
    ///
    /// To specify a maximum `OnDemandThroughput` on your table, set the value of
    /// `MaxWriteRequestUnits` as greater than or equal to 1. To remove the
    /// maximum `OnDemandThroughput` that is currently set on your table, set the
    /// value of `MaxWriteRequestUnits` to -1.
    max_write_request_units: ?i64,
};
