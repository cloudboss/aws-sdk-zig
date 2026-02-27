/// Information related to the utilization of resources that have been billed or
/// charged for in a given context, such as a protected job.
pub const BilledJobResourceUtilization = struct {
    /// The number of Clean Rooms Processing Unit (CRPU) hours that have been
    /// billed.
    units: f64,

    pub const json_field_names = .{
        .units = "units",
    };
};
