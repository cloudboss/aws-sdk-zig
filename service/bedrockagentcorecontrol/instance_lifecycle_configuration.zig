/// The configuration that manages the lifecycle of instances in a capacity
/// provider, including idle timeout and maximum lifetime.
pub const InstanceLifecycleConfiguration = struct {
    /// The number of seconds an instance can remain idle before it is stopped. An
    /// instance is considered idle when all of its agents are idle. The default is
    /// 900 seconds (15 minutes).
    idle_instance_timeout: ?i32 = null,

    /// The maximum lifetime of an instance, in seconds. When an instance reaches
    /// this limit, the service terminates it regardless of activity. The default is
    /// 28800 seconds (8 hours). The maximum is 1209600 seconds (14 days).
    max_lifetime: ?i32 = null,

    pub const json_field_names = .{
        .idle_instance_timeout = "idleInstanceTimeout",
        .max_lifetime = "maxLifetime",
    };
};
