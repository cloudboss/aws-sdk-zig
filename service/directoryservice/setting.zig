/// Contains information about the configurable settings for a directory.
pub const Setting = struct {
    /// The name of the directory setting. For example:
    ///
    /// `TLS_1_0`
    name: []const u8,

    /// The value of the directory setting for which to retrieve information. For
    /// example, for
    /// `TLS_1_0`, the valid values are: `Enable` and
    /// `Disable`.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
