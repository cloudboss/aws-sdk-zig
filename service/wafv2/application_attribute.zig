/// Application details defined during the web ACL creation process. Application
/// attributes help WAF give recommendations for protection packs.
pub const ApplicationAttribute = struct {
    /// Specifies the attribute name.
    name: ?[]const u8 = null,

    /// Specifies the attribute value.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
