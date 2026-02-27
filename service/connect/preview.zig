const AllowedUserAction = @import("allowed_user_action.zig").AllowedUserAction;
const PostAcceptTimeoutConfig = @import("post_accept_timeout_config.zig").PostAcceptTimeoutConfig;

/// Information about agent-first preview mode outbound strategy configuration.
pub const Preview = struct {
    /// The actions the agent can perform after accepting the preview outbound
    /// contact.
    allowed_user_actions: []const AllowedUserAction,

    /// Countdown timer configuration after the agent accepted the preview outbound
    /// contact.
    post_accept_timeout_config: PostAcceptTimeoutConfig,

    pub const json_field_names = .{
        .allowed_user_actions = "AllowedUserActions",
        .post_accept_timeout_config = "PostAcceptTimeoutConfig",
    };
};
