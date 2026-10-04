const SourceFormat = @import("source_format.zig").SourceFormat;
const TargetFormat = @import("target_format.zig").TargetFormat;

/// Contains summary information about a data transformation profile. To
/// retrieve profile content, call `GetDataTransformationProfile`.
pub const DataTransformationProfileSummary = struct {
    /// The timestamp when the profile was last updated.
    last_updated_at: ?i64 = null,

    /// A description of the profile's purpose.
    profile_description: ?[]const u8 = null,

    /// The unique identifier of the profile.
    profile_id: []const u8,

    /// The name of the profile.
    profile_name: ?[]const u8 = null,

    /// The source data format that this profile converts from.
    source_format: SourceFormat,

    /// The target output format of the profile.
    target_format: TargetFormat,

    /// The latest version number of the profile.
    version: i32,

    pub const json_field_names = .{
        .last_updated_at = "LastUpdatedAt",
        .profile_description = "ProfileDescription",
        .profile_id = "ProfileId",
        .profile_name = "ProfileName",
        .source_format = "SourceFormat",
        .target_format = "TargetFormat",
        .version = "Version",
    };
};
