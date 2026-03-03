const BotAliasTestExecutionTarget = @import("bot_alias_test_execution_target.zig").BotAliasTestExecutionTarget;

/// Contains information about the bot used for the test execution.
pub const TestExecutionTarget = struct {
    /// Contains information about the bot alias used for the test execution.
    bot_alias_target: ?BotAliasTestExecutionTarget = null,

    pub const json_field_names = .{
        .bot_alias_target = "botAliasTarget",
    };
};
