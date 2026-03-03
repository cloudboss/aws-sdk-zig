/// The configuration entry associated with the specific portal type. The
/// `portalTypeConfiguration` is a map of the `portalTypeKey` to the
/// `PortalTypeEntry`.
pub const PortalTypeEntry = struct {
    /// The array of tools associated with the specified portal type. The possible
    /// values are `ASSISTANT` and `DASHBOARD`.
    portal_tools: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .portal_tools = "portalTools",
    };
};
