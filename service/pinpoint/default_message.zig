const aws = @import("aws");

/// Specifies the default message for all channels.
pub const DefaultMessage = struct {
    /// The default body of the message.
    body: ?[]const u8,

    /// The default message variables to use in the message. You can override these
    /// default variables with individual address variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .body = "Body",
        .substitutions = "Substitutions",
    };
};
