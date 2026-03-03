/// A ulimit to set in the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsUlimitsDetails = struct {
    /// The hard limit for the ulimit type.
    hard_limit: ?i32 = null,

    /// The type of the ulimit. Valid values are as follows:
    ///
    /// * `core`
    ///
    /// * `cpu`
    ///
    /// * `data`
    ///
    /// * `fsize`
    ///
    /// * `locks`
    ///
    /// * `memlock`
    ///
    /// * `msgqueue`
    ///
    /// * `nice`
    ///
    /// * `nofile`
    ///
    /// * `nproc`
    ///
    /// * `rss`
    ///
    /// * `rtprio`
    ///
    /// * `rttime`
    ///
    /// * `sigpending`
    ///
    /// * `stack`
    name: ?[]const u8 = null,

    /// The soft limit for the ulimit type.
    soft_limit: ?i32 = null,

    pub const json_field_names = .{
        .hard_limit = "HardLimit",
        .name = "Name",
        .soft_limit = "SoftLimit",
    };
};
