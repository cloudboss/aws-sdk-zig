const ShareStatus = @import("share_status.zig").ShareStatus;

/// The details of a resource share.
pub const ShareDetails = struct {
    /// The timestamp of when the resource share was created.
    creation_time: ?i64 = null,

    /// The account ID for the data owner. The owner creates the resource share.
    owner_id: ?[]const u8 = null,

    /// The principal subscriber is the account that is sharing the resource.
    principal_subscriber: ?[]const u8 = null,

    /// The Arn of the shared resource.
    resource_arn: ?[]const u8 = null,

    /// The ID of the shared resource.
    resource_id: ?[]const u8 = null,

    /// The ID of the resource share.
    share_id: ?[]const u8 = null,

    /// The name of the resource share.
    share_name: ?[]const u8 = null,

    /// The status of the share.
    status: ?ShareStatus = null,

    /// The status message for a resource share. It provides additional details
    /// about the share status.
    status_message: ?[]const u8 = null,

    /// The timestamp of the resource share update.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .owner_id = "ownerId",
        .principal_subscriber = "principalSubscriber",
        .resource_arn = "resourceArn",
        .resource_id = "resourceId",
        .share_id = "shareId",
        .share_name = "shareName",
        .status = "status",
        .status_message = "statusMessage",
        .update_time = "updateTime",
    };
};
