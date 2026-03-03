/// Information about a source association in a resource share. Source
/// associations control which sources can be used with service principals.
pub const AssociatedSource = struct {
    /// The date and time when the source association was created.
    creation_time: ?i64 = null,

    /// The date and time when the source association was last updated.
    last_updated_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the resource share that contains the
    /// source association.
    resource_share_arn: ?[]const u8 = null,

    /// The identifier of the source. This can be an account ID, Amazon Resource
    /// Name (ARN), organization ID, or organization path.
    source_id: ?[]const u8 = null,

    /// The type of source.
    source_type: ?[]const u8 = null,

    /// The current status of the source association.
    status: ?[]const u8 = null,

    /// A message about the status of the source association.
    status_message: ?[]const u8 = null,

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
