/// CPU utilization metrics for an instance.
pub const CPUUtilization = struct {
    /// Percentage of time that the CPU has spent in the `Idle` state over the last
    /// 10 seconds.
    idle: ?f64,

    /// Available on Linux environments only.
    ///
    /// Percentage of time that the CPU has spent in the `I/O Wait` state over the
    /// last 10 seconds.
    io_wait: ?f64,

    /// Available on Linux environments only.
    ///
    /// Percentage of time that the CPU has spent in the `IRQ` state over the last
    /// 10 seconds.
    irq: ?f64,

    /// Available on Linux environments only.
    ///
    /// Percentage of time that the CPU has spent in the `Nice` state over the last
    /// 10 seconds.
    nice: ?f64,

    /// Available on Windows environments only.
    ///
    /// Percentage of time that the CPU has spent in the `Privileged` state over the
    /// last 10 seconds.
    privileged: ?f64,

    /// Available on Linux environments only.
    ///
    /// Percentage of time that the CPU has spent in the `SoftIRQ` state over the
    /// last 10 seconds.
    soft_irq: ?f64,

    /// Available on Linux environments only.
    ///
    /// Percentage of time that the CPU has spent in the `System` state over the
    /// last 10 seconds.
    system: ?f64,

    /// Percentage of time that the CPU has spent in the `User` state over the last
    /// 10 seconds.
    user: ?f64,
};
