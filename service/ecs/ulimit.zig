const UlimitName = @import("ulimit_name.zig").UlimitName;

/// The `ulimit` settings to pass to the container.
///
/// Amazon ECS tasks hosted on Fargate use the default resource limit values
/// set by the operating system with the exception of the `nofile` resource
/// limit
/// parameter which Fargate overrides. The `nofile` resource limit sets a
/// restriction on the number of open files that a container can use. The
/// default
/// `nofile` soft limit is ` 65535` and the default hard limit is
/// `65535`.
///
/// You can specify the `ulimit` settings for a container in a task
/// definition.
pub const Ulimit = struct {
    /// The hard limit for the `ulimit` type. The value can be specified in bytes,
    /// seconds, or as a count, depending on the `type` of the
    /// `ulimit`.
    hard_limit: i32 = 0,

    /// The `type` of the `ulimit`.
    name: UlimitName,

    /// The soft limit for the `ulimit` type. The value can be specified in bytes,
    /// seconds, or as a count, depending on the `type` of the
    /// `ulimit`.
    soft_limit: i32 = 0,

    pub const json_field_names = .{
        .hard_limit = "hardLimit",
        .name = "name",
        .soft_limit = "softLimit",
    };
};
