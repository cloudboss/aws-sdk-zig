/// Information that identifies a mitigation action. This information is
/// returned by ListMitigationActions.
pub const MitigationActionIdentifier = struct {
    /// The IAM role ARN used to apply this mitigation action.
    action_arn: ?[]const u8,

    /// The friendly name of the mitigation action.
    action_name: ?[]const u8,

    /// The date when this mitigation action was created.
    creation_date: ?i64,

    pub const json_field_names = .{
        .action_arn = "actionArn",
        .action_name = "actionName",
        .creation_date = "creationDate",
    };
};
