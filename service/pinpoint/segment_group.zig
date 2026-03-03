const SegmentDimensions = @import("segment_dimensions.zig").SegmentDimensions;
const SegmentReference = @import("segment_reference.zig").SegmentReference;
const SourceType = @import("source_type.zig").SourceType;
const Type = @import("type.zig").Type;

/// Specifies the base segments and dimensions for a segment, and the
/// relationships between these base segments and dimensions.
pub const SegmentGroup = struct {
    /// An array that defines the dimensions for the segment.
    dimensions: ?[]const SegmentDimensions = null,

    /// The base segment to build the segment on. A base segment, also referred to
    /// as a *source segment*, defines the initial population of endpoints for a
    /// segment. When you add dimensions to a segment, Amazon Pinpoint filters the
    /// base segment by using the dimensions that you specify.
    ///
    /// You can specify more than one dimensional segment or only one imported
    /// segment. If you specify an imported segment, the Amazon Pinpoint console
    /// displays a segment size estimate that indicates the size of the imported
    /// segment without any filters applied to it.
    source_segments: ?[]const SegmentReference = null,

    /// Specifies how to handle multiple base segments for the segment. For example,
    /// if you specify three base segments for the segment, whether the resulting
    /// segment is based on all, any, or none of the base segments.
    source_type: ?SourceType = null,

    /// Specifies how to handle multiple dimensions for the segment. For example, if
    /// you specify three dimensions for the segment, whether the resulting segment
    /// includes endpoints that match all, any, or none of the dimensions.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .source_segments = "SourceSegments",
        .source_type = "SourceType",
        .@"type" = "Type",
    };
};
