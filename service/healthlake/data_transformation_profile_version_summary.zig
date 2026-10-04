const SourceFormat = @import("source_format.zig").SourceFormat;
const TargetFormat = @import("target_format.zig").TargetFormat;

/// Contains summary information about a specific version of a data
/// transformation profile. To retrieve profile content, call
/// `GetDataTransformationProfile`.
pub const DataTransformationProfileVersionSummary = struct {
    /// A description of what changed in this version.
    change_description: ?[]const u8 = null,

    /// The timestamp when this version was last updated.
    last_updated_at: ?i64 = null,

    /// The unique identifier of the profile.
    profile_id: []const u8,

    /// The name of the profile.
    profile_name: ?[]const u8 = null,

    /// The source data format that this profile converts from.
    source_format: SourceFormat,

    /// The target output format of the profile.
    target_format: TargetFormat,

    /// The version number.
    version: i32,

    pub const json_field_names = .{
        .change_description = "ChangeDescription",
        .last_updated_at = "LastUpdatedAt",
        .profile_id = "ProfileId",
        .profile_name = "ProfileName",
        .source_format = "SourceFormat",
        .target_format = "TargetFormat",
        .version = "Version",
    };
};
