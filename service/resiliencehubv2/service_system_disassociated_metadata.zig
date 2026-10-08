/// Metadata for a service system disassociated event.
pub const ServiceSystemDisassociatedMetadata = struct {
    system_arn: ?[]const u8 = null,

    /// The identifier of the disassociated system.
    system_id: ?[]const u8 = null,

    /// The name of the disassociated system.
    system_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .system_arn = "systemArn",
        .system_id = "systemId",
        .system_name = "systemName",
    };
};
