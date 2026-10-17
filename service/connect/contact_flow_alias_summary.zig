/// Contains summary information about a flow alias.
pub const ContactFlowAliasSummary = struct {
    /// The description of the alias.
    alias_description: ?[]const u8 = null,

    /// The identifier of the alias.
    alias_id: ?[]const u8 = null,

    /// The name of the alias.
    alias_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the flow alias.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The version of the flow.
    version: ?i64 = null,

    pub const json_field_names = .{
        .alias_description = "AliasDescription",
        .alias_id = "AliasId",
        .alias_name = "AliasName",
        .arn = "Arn",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .version = "Version",
    };
};
