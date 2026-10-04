/// Returns info about the resource share error after updating the broker.
pub const ResourceShareError = struct {
    /// The error code of the resource share.
    error_code: ?[]const u8 = null,

    /// The ARN of the resource share.
    resource_share_arn: ?[]const u8 = null,

    /// The status of the resource share.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .resource_share_arn = "ResourceShareArn",
        .status = "Status",
    };
};
