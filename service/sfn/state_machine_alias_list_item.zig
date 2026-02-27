/// Contains details about a specific state machine alias.
pub const StateMachineAliasListItem = struct {
    /// The creation date of a state machine alias.
    creation_date: i64,

    /// The Amazon Resource Name (ARN) that identifies a state machine alias. The
    /// alias ARN is a combination of state machine ARN and the alias name separated
    /// by a colon (:). For example, `stateMachineARN:PROD`.
    state_machine_alias_arn: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .state_machine_alias_arn = "stateMachineAliasArn",
    };
};
