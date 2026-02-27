const aws = @import("aws");

/// Updates CIS targets.
pub const UpdateCisTargets = struct {
    /// The target account ids.
    account_ids: ?[]const []const u8,

    /// The target resource tags.
    target_resource_tags: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .target_resource_tags = "targetResourceTags",
    };
};
