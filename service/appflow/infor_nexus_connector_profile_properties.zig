/// The connector-specific profile properties required by Infor Nexus.
pub const InforNexusConnectorProfileProperties = struct {
    /// The location of the Infor Nexus resource.
    instance_url: []const u8,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
