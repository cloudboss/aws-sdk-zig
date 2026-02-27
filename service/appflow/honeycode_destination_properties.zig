const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;

/// The properties that are applied when Amazon Honeycode is used as a
/// destination.
pub const HoneycodeDestinationProperties = struct {
    error_handling_config: ?ErrorHandlingConfig,

    /// The object specified in the Amazon Honeycode flow destination.
    object: []const u8,

    pub const json_field_names = .{
        .error_handling_config = "errorHandlingConfig",
        .object = "object",
    };
};
