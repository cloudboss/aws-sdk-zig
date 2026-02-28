/// The details of a provisioned resource of this Amazon DataZone environment.
pub const Resource = struct {
    /// The name of a provisioned resource of this Amazon DataZone environment.
    name: ?[]const u8,

    /// The provider of a provisioned resource of this Amazon DataZone environment.
    provider: ?[]const u8,

    /// The type of a provisioned resource of this Amazon DataZone environment.
    type: []const u8,

    /// The value of a provisioned resource of this Amazon DataZone environment.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .provider = "provider",
        .type = "type",
        .value = "value",
    };
};
