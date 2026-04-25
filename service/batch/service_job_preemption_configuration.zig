/// Specifies the service job behavior when preempted.
pub const ServiceJobPreemptionConfiguration = struct {
    /// The number of times a service job can be retried after it is preempted. A
    /// job will be terminated when preemption retries have been exhausted.
    /// If this field is unset, preempted jobs will be requeued an unlimited number
    /// of times.
    preemption_retries_before_termination: ?i32 = null,

    pub const json_field_names = .{
        .preemption_retries_before_termination = "preemptionRetriesBeforeTermination",
    };
};
