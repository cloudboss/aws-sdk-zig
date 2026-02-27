const AudienceSizeType = @import("audience_size_type.zig").AudienceSizeType;

/// Returns the relevance scores at these audience sizes when used in the
/// GetAudienceGenerationJob for a specified audience generation job and
/// configured audience model.
///
/// Specifies the list of allowed `audienceSize` values when used in the
/// StartAudienceExportJob for an audience generation job. You can use the
/// `ABSOLUTE` AudienceSize to configure out audience sizes using the count of
/// identifiers in the output. You can use the `Percentage` AudienceSize to
/// configure sizes in the range 1-100 percent.
pub const AudienceSizeConfig = struct {
    /// An array of the different audience output sizes.
    audience_size_bins: []const i32,

    /// Whether the audience output sizes are defined as an absolute number or a
    /// percentage.
    audience_size_type: AudienceSizeType,

    pub const json_field_names = .{
        .audience_size_bins = "audienceSizeBins",
        .audience_size_type = "audienceSizeType",
    };
};
