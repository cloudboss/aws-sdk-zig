const MediaPlacement = @import("media_placement.zig").MediaPlacement;
const MeetingFeaturesConfiguration = @import("meeting_features_configuration.zig").MeetingFeaturesConfiguration;

/// A meeting created using the Amazon Chime SDK.
pub const Meeting = struct {
    /// The external meeting ID.
    ///
    /// Pattern: `[-_&@+=,(){}\[\]\/«».:|'"#a-zA-Z0-9À-ÿ\s]*`
    ///
    /// Values that begin with `aws:` are reserved. You can't configure a value that
    /// uses this prefix.
    /// Case insensitive.
    external_meeting_id: ?[]const u8,

    /// The media placement for the meeting.
    media_placement: ?MediaPlacement,

    /// The Region in which you create the meeting. Available values: `af-south-1`,
    /// `ap-northeast-1`,
    /// `ap-northeast-2`, `ap-south-1`, `ap-southeast-1`, `ap-southeast-2`,
    /// `ca-central-1`,
    /// `eu-central-1`, `eu-north-1`, `eu-south-1`,
    /// `eu-west-1`, `eu-west-2`, `eu-west-3`,
    /// `sa-east-1`, `us-east-1`, `us-east-2`,
    /// `us-west-1`, `us-west-2`.
    ///
    /// Available values in Amazon Web Services GovCloud (US) Regions:
    /// `us-gov-east-1`, `us-gov-west-1`.
    media_region: ?[]const u8,

    /// The ARN of the meeting.
    meeting_arn: ?[]const u8,

    /// The features available to a meeting, such as echo reduction.
    meeting_features: ?MeetingFeaturesConfiguration,

    /// Reserved.
    meeting_host_id: ?[]const u8,

    /// The Amazon Chime SDK meeting ID.
    meeting_id: ?[]const u8,

    /// When specified, replicates the media from the primary meeting to this
    /// meeting.
    primary_meeting_id: ?[]const u8,

    /// Array of strings.
    tenant_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .external_meeting_id = "ExternalMeetingId",
        .media_placement = "MediaPlacement",
        .media_region = "MediaRegion",
        .meeting_arn = "MeetingArn",
        .meeting_features = "MeetingFeatures",
        .meeting_host_id = "MeetingHostId",
        .meeting_id = "MeetingId",
        .primary_meeting_id = "PrimaryMeetingId",
        .tenant_ids = "TenantIds",
    };
};
