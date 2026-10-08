const StateMachineType = @import("state_machine_type.zig").StateMachineType;

/// Contains details about the state machine.
pub const StateMachineListItem = struct {
    /// The date the state machine is created.
    creation_date: i64,

    /// The name of the state machine.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: []const u8,

    /// The Amazon Resource Name (ARN) that identifies the state machine.
    state_machine_arn: []const u8,

    type: StateMachineType,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .name = "name",
        .state_machine_arn = "stateMachineArn",
        .type = "type",
    };
};
