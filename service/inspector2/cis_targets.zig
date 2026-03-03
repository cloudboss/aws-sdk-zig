const aws = @import("aws");

/// The CIS targets.
pub const CisTargets = struct {
    /// The CIS target account ids.
    account_ids: ?[]const []const u8 = null,

    /// The CIS target resource tags.
    target_resource_tags: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .target_resource_tags = "targetResourceTags",
    };
};
