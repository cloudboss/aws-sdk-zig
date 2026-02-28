const CommentMetadata = @import("comment_metadata.zig").CommentMetadata;
const UserMetadata = @import("user_metadata.zig").UserMetadata;
const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const Participants = @import("participants.zig").Participants;
const ActivityType = @import("activity_type.zig").ActivityType;

/// Describes the activity information.
pub const Activity = struct {
    /// Metadata of the commenting activity. This is an optional field and is filled
    /// for
    /// commenting activities.
    comment_metadata: ?CommentMetadata,

    /// The user who performed the action.
    initiator: ?UserMetadata,

    /// Indicates whether an activity is indirect or direct. An indirect activity
    /// results
    /// from a direct activity performed on a parent resource. For example, sharing
    /// a parent
    /// folder (the direct activity) shares all of the subfolders and documents
    /// within the
    /// parent folder (the indirect activity).
    is_indirect_activity: bool = false,

    /// The ID of the organization.
    organization_id: ?[]const u8,

    /// The original parent of the resource. This is an optional field and is filled
    /// for
    /// move activities.
    original_parent: ?ResourceMetadata,

    /// The list of users or groups impacted by this action. This is an optional
    /// field and
    /// is filled for the following sharing activities: DOCUMENT_SHARED,
    /// DOCUMENT_SHARED,
    /// DOCUMENT_UNSHARED, FOLDER_SHARED, FOLDER_UNSHARED.
    participants: ?Participants,

    /// The metadata of the resource involved in the user action.
    resource_metadata: ?ResourceMetadata,

    /// The timestamp when the action was performed.
    time_stamp: ?i64,

    /// The activity type.
    @"type": ?ActivityType,

    pub const json_field_names = .{
        .comment_metadata = "CommentMetadata",
        .initiator = "Initiator",
        .is_indirect_activity = "IsIndirectActivity",
        .organization_id = "OrganizationId",
        .original_parent = "OriginalParent",
        .participants = "Participants",
        .resource_metadata = "ResourceMetadata",
        .time_stamp = "TimeStamp",
        .@"type" = "Type",
    };
};
