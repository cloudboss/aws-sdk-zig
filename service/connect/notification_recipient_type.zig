const aws = @import("aws");

/// The type of notification recipient.
pub const NotificationRecipientType = struct {
    /// A list of user IDs. Supports variable injection of
    /// `$.ContactLens.ContactEvaluation.Agent.AgentId`
    /// for `OnContactEvaluationSubmit` event source.
    user_ids: ?[]const []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }. Amazon Connect
    /// users with the specified tags will be notified.
    user_tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .user_ids = "UserIds",
        .user_tags = "UserTags",
    };
};
