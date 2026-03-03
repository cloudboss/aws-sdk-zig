const VerifiedAccessSseSpecificationResponse = @import("verified_access_sse_specification_response.zig").VerifiedAccessSseSpecificationResponse;
const Tag = @import("tag.zig").Tag;

/// Describes a Verified Access group.
pub const VerifiedAccessGroup = struct {
    /// The creation time.
    creation_time: ?[]const u8 = null,

    /// The deletion time.
    deletion_time: ?[]const u8 = null,

    /// A description for the Amazon Web Services Verified Access group.
    description: ?[]const u8 = null,

    /// The last updated time.
    last_updated_time: ?[]const u8 = null,

    /// The Amazon Web Services account number that owns the group.
    owner: ?[]const u8 = null,

    /// The options in use for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationResponse = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The ARN of the Verified Access group.
    verified_access_group_arn: ?[]const u8 = null,

    /// The ID of the Verified Access group.
    verified_access_group_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services Verified Access instance.
    verified_access_instance_id: ?[]const u8 = null,
};
