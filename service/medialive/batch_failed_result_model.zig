/// Details from a failed operation
pub const BatchFailedResultModel = struct {
    /// ARN of the resource
    arn: ?[]const u8 = null,

    /// Error code for the failed operation
    code: ?[]const u8 = null,

    /// ID of the resource
    id: ?[]const u8 = null,

    /// Error message for the failed operation
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .code = "Code",
        .id = "Id",
        .message = "Message",
    };
};
