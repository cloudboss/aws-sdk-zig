const ImageTagMutabilityExclusionFilterType = @import("image_tag_mutability_exclusion_filter_type.zig").ImageTagMutabilityExclusionFilterType;

/// A filter that specifies which image tags should be excluded from the
/// repository's
/// image tag mutability setting.
pub const ImageTagMutabilityExclusionFilter = struct {
    /// The filter value used to match image tags for exclusion from mutability
    /// settings.
    filter: []const u8,

    /// The type of filter to apply for excluding image tags from mutability
    /// settings.
    filter_type: ImageTagMutabilityExclusionFilterType,

    pub const json_field_names = .{
        .filter = "filter",
        .filter_type = "filterType",
    };
};
