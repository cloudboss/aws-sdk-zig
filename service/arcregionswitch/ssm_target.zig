/// A single `SendCommand` target filter, consisting of a target key and the
/// values matched by that key.
pub const SsmTarget = struct {
    /// The target key, such as `tag:Environment` or `InstanceIds`.
    key: []const u8,

    /// The values matched by this target key. Multiple values combine with a
    /// logical OR.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
