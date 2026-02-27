/// An object that describes workflow billing details.
pub const BillingDetails = struct {
    /// Billed duration of your workflow, in milliseconds.
    billed_duration_in_milliseconds: i64 = 0,

    /// Billed memory consumption of your workflow, in MB.
    billed_memory_used_in_mb: i64 = 0,

    pub const json_field_names = .{
        .billed_duration_in_milliseconds = "billedDurationInMilliseconds",
        .billed_memory_used_in_mb = "billedMemoryUsedInMB",
    };
};
