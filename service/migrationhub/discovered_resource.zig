/// Object representing the on-premises resource being migrated.
pub const DiscoveredResource = struct {
    /// The configurationId in Application Discovery Service that uniquely
    /// identifies the
    /// on-premise resource.
    configuration_id: []const u8,

    /// A description that can be free-form text to record additional detail about
    /// the
    /// discovered resource for clarity or later reference.
    description: ?[]const u8,

    pub const json_field_names = .{
        .configuration_id = "ConfigurationId",
        .description = "Description",
    };
};
