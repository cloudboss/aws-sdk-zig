/// An auto-termination policy for an Amazon EMR cluster. An auto-termination
/// policy
/// defines the amount of idle time in seconds after which a cluster
/// automatically terminates.
/// For alternative cluster termination options, see [Control cluster
/// termination](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-termination.html).
pub const AutoTerminationPolicy = struct {
    /// Specifies the amount of idle time in seconds after which the cluster
    /// automatically
    /// terminates. You can specify a minimum of 60 seconds and a maximum of 604800
    /// seconds (seven
    /// days).
    idle_timeout: ?i64 = null,

    pub const json_field_names = .{
        .idle_timeout = "IdleTimeout",
    };
};
