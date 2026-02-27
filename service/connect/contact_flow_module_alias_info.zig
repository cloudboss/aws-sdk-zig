/// Contains information about an alias.
pub const ContactFlowModuleAliasInfo = struct {
    /// The identifier of the alias.
    alias_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the flow module.
    contact_flow_module_arn: ?[]const u8,

    /// The identifier of the flow module.
    contact_flow_module_id: ?[]const u8,

    /// The description of the alias.
    description: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the alias.
    name: ?[]const u8,

    /// The version of the flow module.
    version: ?i64,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .contact_flow_module_arn = "ContactFlowModuleArn",
        .contact_flow_module_id = "ContactFlowModuleId",
        .description = "Description",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .version = "Version",
    };
};
