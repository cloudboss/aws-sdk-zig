/// The `ulimit` settings to pass to the container. For more information, see
/// [Ulimit](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_Ulimit.html).
///
/// This object isn't applicable to jobs that are running on Fargate resources.
pub const Ulimit = struct {
    /// The hard limit for the `ulimit` type.
    hard_limit: i32,

    /// The `type` of the `ulimit`. Valid values are: `core` |
    /// `cpu` | `data` | `fsize` | `locks` |
    /// `memlock` | `msgqueue` | `nice` | `nofile` |
    /// `nproc` | `rss` | `rtprio` | `rttime` |
    /// `sigpending` | `stack`.
    name: []const u8,

    /// The soft limit for the `ulimit` type.
    soft_limit: i32,

    pub const json_field_names = .{
        .hard_limit = "hardLimit",
        .name = "name",
        .soft_limit = "softLimit",
    };
};
