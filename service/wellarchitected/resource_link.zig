/// An external reference associated with remediation steps.
pub const ResourceLink = struct {
    /// An optional human-readable title for the link.
    title: ?[]const u8 = null,

    /// The URL of the external reference.
    url: []const u8,

    pub const json_field_names = .{
        .title = "title",
        .url = "url",
    };
};
