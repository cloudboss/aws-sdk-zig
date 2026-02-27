/// Contains details about a specific state machine version.
pub const StateMachineVersionListItem = struct {
    /// The creation date of a state machine version.
    creation_date: i64,

    /// The Amazon Resource Name (ARN) that identifies a state machine version. The
    /// version ARN is a combination of state machine ARN and the version number
    /// separated by a colon (:). For example, `stateMachineARN:1`.
    state_machine_version_arn: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .state_machine_version_arn = "stateMachineVersionArn",
    };
};
