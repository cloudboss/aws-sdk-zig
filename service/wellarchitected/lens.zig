const aws = @import("aws");

/// A lens return object.
pub const Lens = struct {
    description: ?[]const u8,

    /// The ARN of a lens.
    lens_arn: ?[]const u8,

    /// The version of a lens.
    lens_version: ?[]const u8,

    name: ?[]const u8,

    /// The Amazon Web Services account ID that owns the lens.
    owner: ?[]const u8,

    /// The ID assigned to the share invitation.
    share_invitation_id: ?[]const u8,

    /// The tags assigned to the lens.
    tags: ?[]const aws.map.StringMapEntry,

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
