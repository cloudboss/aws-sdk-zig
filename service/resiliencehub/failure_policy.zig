/// Defines a failure policy.
pub const FailurePolicy = struct {
    /// Recovery Point Objective (RPO) in seconds.
    rpo_in_secs: i32 = 0,

    /// Recovery Time Objective (RTO) in seconds.
    rto_in_secs: i32 = 0,

    pub const json_field_names = .{
        .rpo_in_secs = "rpoInSecs",
        .rto_in_secs = "rtoInSecs",
    };
};
