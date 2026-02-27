/// The amount of ephemeral storage to allocate for the task. This parameter is
/// used to expand
/// the total amount of ephemeral storage available, beyond the default amount,
/// for tasks hosted on
/// Fargate.
pub const EphemeralStorage = struct {
    /// The total amount, in GiB, of ephemeral storage to set for the task. The
    /// minimum supported
    /// value is `21` GiB and the maximum supported value is `200` GiB.
    size_in_gi_b: i32,

    pub const json_field_names = .{
        .size_in_gi_b = "sizeInGiB",
    };
};
