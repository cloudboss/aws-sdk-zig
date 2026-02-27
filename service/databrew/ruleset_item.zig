const aws = @import("aws");

/// Contains metadata about the ruleset.
pub const RulesetItem = struct {
    /// The ID of the Amazon Web Services account that owns the ruleset.
    account_id: ?[]const u8,

    /// The date and time that the ruleset was created.
    create_date: ?i64,

    /// The Amazon Resource Name (ARN) of the user who created the ruleset.
    created_by: ?[]const u8,

    /// The description of the ruleset.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who last modified the ruleset.
    last_modified_by: ?[]const u8,

    /// The modification date and time of the ruleset.
    last_modified_date: ?i64,

    /// The name of the ruleset.
    name: []const u8,

    /// The Amazon Resource Name (ARN) for the ruleset.
    resource_arn: ?[]const u8,

    /// The number of rules that are defined in the ruleset.
    rule_count: i32 = 0,

    /// Metadata tags that have been applied to the ruleset.
    tags: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of a resource (dataset) that the ruleset is
    /// associated with.
    target_arn: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .description = "Description",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .resource_arn = "ResourceArn",
        .rule_count = "RuleCount",
        .tags = "Tags",
        .target_arn = "TargetArn",
    };
};
