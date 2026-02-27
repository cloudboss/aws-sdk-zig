const ExperienceEndpoint = @import("experience_endpoint.zig").ExperienceEndpoint;
const ExperienceStatus = @import("experience_status.zig").ExperienceStatus;

/// Summary information for your Amazon Kendra experience. You can create an
/// Amazon Kendra
/// experience such as a search application. For more information on creating
/// a search application experience, see [Building
/// a search experience with no
/// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
pub const ExperiencesSummary = struct {
    /// The Unix timestamp when your Amazon Kendra experience was created.
    created_at: ?i64,

    /// The endpoint URLs for your Amazon Kendra experiences. The URLs are unique
    /// and fully hosted by Amazon Web Services.
    endpoints: ?[]const ExperienceEndpoint,

    /// The identifier of your Amazon Kendra experience.
    id: ?[]const u8,

    /// The name of your Amazon Kendra experience.
    name: ?[]const u8,

    /// The processing status of your Amazon Kendra experience.
    status: ?ExperienceStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .endpoints = "Endpoints",
        .id = "Id",
        .name = "Name",
        .status = "Status",
    };
};
