/// Represents the minimum and maximum capacity for a scheduled action.
pub const ScalableTargetAction = struct {
    /// The maximum capacity.
    ///
    /// Although you can specify a large maximum capacity, note that service quotas
    /// may impose
    /// lower limits. Each service has its own default quotas for the maximum
    /// capacity of the
    /// resource. If you want to specify a higher limit, you can request an
    /// increase. For more
    /// information, consult the documentation for that service. For information
    /// about the default
    /// quotas for each service, see [Service endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/aws-service-information.html) in the *Amazon Web Services General Reference*.
    max_capacity: ?i32 = null,

    /// The minimum capacity.
    ///
    /// When the scheduled action runs, the resource will have at least this much
    /// capacity, but it
    /// might have more depending on other settings, such as the target utilization
    /// level of a target
    /// tracking scaling policy.
    min_capacity: ?i32 = null,

    pub const json_field_names = .{
        .max_capacity = "MaxCapacity",
        .min_capacity = "MinCapacity",
    };
};
