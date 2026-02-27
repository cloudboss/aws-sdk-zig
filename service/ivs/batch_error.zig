/// Error related to a specific channel, specified by its ARN.
pub const BatchError = struct {
    /// ARN of an IVS resource; e.g., channel.
    arn: ?[]const u8,

    /// Error code.
    code: ?[]const u8,

    /// Error message, determined by the application.
    message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .code = "code",
        .message = "message",
    };
};
