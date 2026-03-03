const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;

/// The properties that are applied when Amazon EventBridge is being used as a
/// destination.
pub const EventBridgeDestinationProperties = struct {
    error_handling_config: ?ErrorHandlingConfig = null,

    /// The object specified in the Amazon EventBridge flow destination.
    object: []const u8,

    pub const json_field_names = .{
        .error_handling_config = "errorHandlingConfig",
        .object = "object",
    };
};
