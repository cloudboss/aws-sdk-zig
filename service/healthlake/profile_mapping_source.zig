const aws = @import("aws");

/// Contains raw content to use as the source when creating a data
/// transformation profile directly from a mapping.
pub const ProfileMappingSource = struct {
    /// The content as a map of file paths to profile strings.
    profile_mapping: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .profile_mapping = "ProfileMapping",
    };
};
