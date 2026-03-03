const AlternateMedia = @import("alternate_media.zig").AlternateMedia;

/// An AudienceMedia object contains an Audience and a list of AlternateMedia.
pub const AudienceMedia = struct {
    /// The list of AlternateMedia defined in AudienceMedia.
    alternate_media: ?[]const AlternateMedia = null,

    /// The Audience defined in AudienceMedia.
    audience: ?[]const u8 = null,

    pub const json_field_names = .{
        .alternate_media = "AlternateMedia",
        .audience = "Audience",
    };
};
