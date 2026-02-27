/// Identifying information for a Device Defender security profile.
pub const SecurityProfileIdentifier = struct {
    /// The ARN of the security profile.
    arn: []const u8,

    /// The name you've given to the security profile.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
