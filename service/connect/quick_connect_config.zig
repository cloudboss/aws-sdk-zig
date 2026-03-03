const FlowQuickConnectConfig = @import("flow_quick_connect_config.zig").FlowQuickConnectConfig;
const PhoneNumberQuickConnectConfig = @import("phone_number_quick_connect_config.zig").PhoneNumberQuickConnectConfig;
const QueueQuickConnectConfig = @import("queue_quick_connect_config.zig").QueueQuickConnectConfig;
const QuickConnectType = @import("quick_connect_type.zig").QuickConnectType;
const UserQuickConnectConfig = @import("user_quick_connect_config.zig").UserQuickConnectConfig;

/// Contains configuration settings for a quick connect.
pub const QuickConnectConfig = struct {
    /// Flow configuration for quick connect setup.
    flow_config: ?FlowQuickConnectConfig = null,

    /// The phone configuration. This is required only if QuickConnectType is
    /// PHONE_NUMBER.
    phone_config: ?PhoneNumberQuickConnectConfig = null,

    /// The queue configuration. This is required only if QuickConnectType is QUEUE.
    queue_config: ?QueueQuickConnectConfig = null,

    /// The type of quick connect. In the Amazon Connect admin website, when you
    /// create a quick connect, you are
    /// prompted to assign one of the following types: Agent (USER), External
    /// (PHONE_NUMBER), or Queue (QUEUE).
    quick_connect_type: QuickConnectType,

    /// The user configuration. This is required only if QuickConnectType is USER.
    user_config: ?UserQuickConnectConfig = null,

    pub const json_field_names = .{
        .flow_config = "FlowConfig",
        .phone_config = "PhoneConfig",
        .queue_config = "QueueConfig",
        .quick_connect_type = "QuickConnectType",
        .user_config = "UserConfig",
    };
};
