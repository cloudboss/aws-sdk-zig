const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;

/// The properties that Amazon AppFlow applies when you use Marketo as a flow
/// destination.
pub const MarketoDestinationProperties = struct {
    error_handling_config: ?ErrorHandlingConfig,

    /// The object specified in the Marketo flow destination.
    object: []const u8,

    pub const json_field_names = .{
        .error_handling_config = "errorHandlingConfig",
        .object = "object",
    };
};
