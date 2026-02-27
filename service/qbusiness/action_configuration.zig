const ActionFilterConfiguration = @import("action_filter_configuration.zig").ActionFilterConfiguration;

/// Specifies an allowed action and its associated filter configuration.
pub const ActionConfiguration = struct {
    /// The Amazon Q Business action that is allowed.
    action: []const u8,

    /// The filter configuration for the action, if any.
    filter_configuration: ?ActionFilterConfiguration,

    pub const json_field_names = .{
        .action = "action",
        .filter_configuration = "filterConfiguration",
    };
};
