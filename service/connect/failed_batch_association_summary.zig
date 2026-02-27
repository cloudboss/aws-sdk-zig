/// Contains information about a resource that failed to be associated with a
/// workspace in a batch operation.
pub const FailedBatchAssociationSummary = struct {
    /// The error code indicating why the association failed.
    error_code: ?[]const u8,

    /// An error message describing why the association failed.
    error_message: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the resource that failed to be associated.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .resource_arn = "ResourceArn",
    };
};
