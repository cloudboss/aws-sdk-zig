const CodeHookSpecification = @import("code_hook_specification.zig").CodeHookSpecification;

/// Specifies settings that are unique to a locale. For example, you can
/// use different Lambda function depending on the bot's locale.
pub const BotAliasLocaleSettings = struct {
    /// Specifies the Lambda function that should be used in the
    /// locale.
    code_hook_specification: ?CodeHookSpecification = null,

    /// Determines whether the locale is enabled for the bot. If the value
    /// is `false`, the locale isn't available for use.
    enabled: bool = false,

    pub const json_field_names = .{
        .code_hook_specification = "codeHookSpecification",
        .enabled = "enabled",
    };
};
