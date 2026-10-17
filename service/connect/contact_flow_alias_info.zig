/// Contains information about a flow alias.
pub const ContactFlowAliasInfo = struct {
    /// The identifier of the alias.
    alias_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the flow.
    contact_flow_arn: ?[]const u8 = null,

    /// The identifier of the flow.
    contact_flow_id: ?[]const u8 = null,

    /// The description of the alias.
    description: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the alias.
    name: ?[]const u8 = null,

    /// The version of the flow.
    version: ?i64 = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .contact_flow_arn = "ContactFlowArn",
        .contact_flow_id = "ContactFlowId",
        .description = "Description",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .version = "Version",
    };
};
