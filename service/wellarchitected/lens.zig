const aws = @import("aws");

/// A lens return object.
pub const Lens = struct {
    description: ?[]const u8 = null,

    /// The ARN of a lens.
    lens_arn: ?[]const u8 = null,

    /// The version of a lens.
    lens_version: ?[]const u8 = null,

    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID that owns the lens.
    owner: ?[]const u8 = null,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8 = null,

    /// The tags assigned to the lens.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .lens_arn = "LensArn",
        .lens_version = "LensVersion",
        .name = "Name",
        .owner = "Owner",
        .share_invitation_id = "ShareInvitationId",
        .tags = "Tags",
    };
};
