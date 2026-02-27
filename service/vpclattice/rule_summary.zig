/// Summary information about a listener rule.
pub const RuleSummary = struct {
    /// The Amazon Resource Name (ARN) of the rule.
    arn: ?[]const u8,

    /// The date and time that the listener rule was created, in ISO-8601 format.
    created_at: ?i64,

    /// The ID of the rule.
    id: ?[]const u8,

    /// Indicates whether this is the default listener rule.
    is_default: ?bool,

    /// The date and time that the listener rule was last updated, in ISO-8601
    /// format.
    last_updated_at: ?i64,

    /// The name of the rule.
    name: ?[]const u8,

    /// The priority of the rule.
    priority: ?i32,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .is_default = "isDefault",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .priority = "priority",
    };
};
