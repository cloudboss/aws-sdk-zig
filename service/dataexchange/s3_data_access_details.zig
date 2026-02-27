/// Extra details specific to the affected scope in this S3 Data Access data
/// set.
pub const S3DataAccessDetails = struct {
    /// A
    /// list of the key prefixes affected by this
    /// notification. This
    /// can have up to 50 entries.
    key_prefixes: ?[]const []const u8,

    /// A
    /// list of the keys affected by this
    /// notification. This
    /// can have up to 50 entries.
    keys: ?[]const []const u8,

    pub const json_field_names = .{
        .key_prefixes = "KeyPrefixes",
        .keys = "Keys",
    };
};
