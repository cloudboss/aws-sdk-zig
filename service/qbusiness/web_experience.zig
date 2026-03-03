const WebExperienceStatus = @import("web_experience_status.zig").WebExperienceStatus;

/// Provides information for an Amazon Q Business web experience.
pub const WebExperience = struct {
    /// The Unix timestamp when the Amazon Q Business application was last updated.
    created_at: ?i64 = null,

    /// The endpoint URLs for your Amazon Q Business web experience. The URLs are
    /// unique and fully hosted by Amazon Web Services.
    default_endpoint: ?[]const u8 = null,

    /// The status of your Amazon Q Business web experience.
    status: ?WebExperienceStatus = null,

    /// The Unix timestamp when your Amazon Q Business web experience was updated.
    updated_at: ?i64 = null,

    /// The identifier of your Amazon Q Business web experience.
    web_experience_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .default_endpoint = "defaultEndpoint",
        .status = "status",
        .updated_at = "updatedAt",
        .web_experience_id = "webExperienceId",
    };
};
