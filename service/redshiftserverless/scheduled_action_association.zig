/// Contains names of objects associated with a scheduled action.
pub const ScheduledActionAssociation = struct {
    /// Name of associated Amazon Redshift Serverless namespace.
    namespace_name: ?[]const u8 = null,

    /// Name of associated scheduled action.
    scheduled_action_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespace_name = "namespaceName",
        .scheduled_action_name = "scheduledActionName",
    };
};
