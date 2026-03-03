/// An object that represents the details about the remediation exception. The
/// details include the rule name, an explanation of an exception, the time when
/// the exception will be deleted, the resource ID, and resource type.
pub const RemediationException = struct {
    /// The name of the Config rule.
    config_rule_name: []const u8,

    /// The time when the remediation exception will be deleted.
    expiration_time: ?i64 = null,

    /// An explanation of an remediation exception.
    message: ?[]const u8 = null,

    /// The ID of the resource (for example., sg-xxxxxx).
    resource_id: []const u8,

    /// The type of a resource.
    resource_type: []const u8,

    pub const json_field_names = .{
        .config_rule_name = "ConfigRuleName",
        .expiration_time = "ExpirationTime",
        .message = "Message",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
