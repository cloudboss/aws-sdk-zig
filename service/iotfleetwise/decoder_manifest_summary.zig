const ManifestStatus = @import("manifest_status.zig").ManifestStatus;

/// Information about a created decoder manifest. You can use the API operation
/// to return this information about
/// multiple decoder manifests.
pub const DecoderManifestSummary = struct {
    /// The ARN of a vehicle model (model manifest) associated with the decoder
    /// manifest.
    arn: ?[]const u8,

    /// The time the decoder manifest was created in seconds since epoch (January 1,
    /// 1970 at
    /// midnight UTC time).
    creation_time: i64,

    /// A brief description of the decoder manifest.
    description: ?[]const u8,

    /// The time the decoder manifest was last updated in seconds since epoch
    /// (January 1, 1970
    /// at midnight UTC time).
    last_modification_time: i64,

    /// The detailed message for the decoder manifest. When a decoder manifest is in
    /// an
    /// `INVALID` status, the message contains detailed reason and help
    /// information.
    message: ?[]const u8,

    /// The ARN of a vehicle model (model manifest) associated with the decoder
    /// manifest.
    model_manifest_arn: ?[]const u8,

    /// The name of the decoder manifest.
    name: ?[]const u8,

    /// The state of the decoder manifest. If the status is `ACTIVE`, the decoder
    /// manifest can't be edited. If the status is marked `DRAFT`, you can edit the
    /// decoder manifest.
    status: ?ManifestStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .last_modification_time = "lastModificationTime",
        .message = "message",
        .model_manifest_arn = "modelManifestArn",
        .name = "name",
        .status = "status",
    };
};
