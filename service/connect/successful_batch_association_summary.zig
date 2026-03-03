/// Contains information about a resource that was successfully associated with
/// a workspace in a batch
/// operation.
pub const SuccessfulBatchAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the resource that was successfully
    /// associated.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
