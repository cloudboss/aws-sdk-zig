/// Details from a failed operation
pub const BatchFailedResultModel = struct {
    /// ARN of the resource
    arn: ?[]const u8,

    /// Error code for the failed operation
    code: ?[]const u8,

    /// ID of the resource
    id: ?[]const u8,

    /// Error message for the failed operation
    message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .code = "Code",
        .id = "Id",
        .message = "Message",
    };
};
