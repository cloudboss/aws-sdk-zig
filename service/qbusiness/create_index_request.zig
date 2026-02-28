const IndexCapacityConfiguration = @import("index_capacity_configuration.zig").IndexCapacityConfiguration;
const Tag = @import("tag.zig").Tag;
const IndexType = @import("index_type.zig").IndexType;

pub const CreateIndexRequest = struct {
    /// The identifier of the Amazon Q Business application using the index.
    application_id: []const u8,

    /// The capacity units you want to provision for your index. You can add and
    /// remove capacity to fit your usage needs.
    capacity_configuration: ?IndexCapacityConfiguration,

    /// A token that you provide to identify the request to create an index.
    /// Multiple calls to the `CreateIndex` API with the same client token will
    /// create only one index.
    client_token: ?[]const u8,

    /// A description for the Amazon Q Business index.
    description: ?[]const u8,

    /// A name for the Amazon Q Business index.
    display_name: []const u8,

    /// A list of key-value pairs that identify or categorize the index. You can
    /// also use tags to help control access to the index. Tag keys and values can
    /// consist of Unicode letters, digits, white space, and any of the following
    /// symbols: _ . : / = + - @.
    tags: ?[]const Tag,

    /// The index type that's suitable for your needs. For more information on
    /// what's included in each type of index, see [Amazon Q Business
    /// tiers](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/tiers.html#index-tiers).
    @"type": ?IndexType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capacity_configuration = "capacityConfiguration",
        .client_token = "clientToken",
        .description = "description",
        .display_name = "displayName",
        .tags = "tags",
        .@"type" = "type",
    };
};
