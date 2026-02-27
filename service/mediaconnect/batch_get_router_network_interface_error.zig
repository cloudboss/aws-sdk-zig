/// An error that occurred when retrieving multiple router network interfaces in
/// the BatchGetRouterNetworkInterface operation, including the ARN, error code,
/// and error message.
pub const BatchGetRouterNetworkInterfaceError = struct {
    /// The Amazon Resource Name (ARN) of the router network interface for which the
    /// error occurred.
    arn: []const u8,

    /// The error code associated with the error.
    code: []const u8,

    /// A message describing the error.
    message: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .code = "Code",
        .message = "Message",
    };
};
