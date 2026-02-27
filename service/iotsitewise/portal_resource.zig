/// Identifies an IoT SiteWise Monitor portal.
pub const PortalResource = struct {
    /// The ID of the portal.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
