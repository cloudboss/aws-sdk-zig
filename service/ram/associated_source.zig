/// Information about a source association in a resource share. Source
/// associations control which sources can be used with service principals.
pub const AssociatedSource = struct {
    /// The date and time when the source association was created.
    creation_time: ?i64,

    /// The date and time when the source association was last updated.
    last_updated_time: ?i64,

    /// The Amazon Resource Name (ARN) of the resource share that contains the
    /// source association.
    resource_share_arn: ?[]const u8,

    /// The identifier of the source. This can be an account ID, Amazon Resource
    /// Name (ARN), organization ID, or organization path.
    source_id: ?[]const u8,

    /// The type of source.
    source_type: ?[]const u8,

    /// The current status of the source association.
    status: ?[]const u8,

    /// A message about the status of the source association.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .last_updated_time = "lastUpdatedTime",
        .resource_share_arn = "resourceShareArn",
        .source_id = "sourceId",
        .source_type = "sourceType",
        .status = "status",
        .status_message = "statusMessage",
    };
};
