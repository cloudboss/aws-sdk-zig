/// The name and value of a user attribute.
pub const AttributeType = struct {
    /// The name of the attribute, for example `email` or
    /// `custom:department`.
    ///
    /// In some older user pools, the regex pattern for acceptable values of this
    /// parameter is
    /// `[\p{L}\p{M}\p{S}\p{N}\p{P}]+`. Older pools will eventually be updated to
    /// use the new pattern. Affected user pools are those created before May 2024
    /// in
    /// US East (N. Virginia), US East (Ohio), US West (N. California), US West
    /// (Oregon),
    /// Asia Pacific (Mumbai), Asia Pacific (Tokyo), Asia Pacific (Seoul),
    /// Asia Pacific (Singapore), Asia Pacific (Sydney), Canada (Central),
    /// Europe (Frankfurt), Europe (Ireland), Europe (London), Europe (Paris),
    /// Europe (Stockholm), Middle East (Bahrain), and South America (São Paulo).
    name: []const u8,

    /// The value of the attribute.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
