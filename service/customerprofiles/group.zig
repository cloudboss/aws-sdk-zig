const Dimension = @import("dimension.zig").Dimension;
const SourceSegment = @import("source_segment.zig").SourceSegment;
const IncludeOptions = @import("include_options.zig").IncludeOptions;

/// Contains dimensions that determine what to segment on.
pub const Group = struct {
    /// Defines the attributes to segment on.
    dimensions: ?[]const Dimension = null,

    /// Defines the starting source of data.
    source_segments: ?[]const SourceSegment = null,

    /// Defines how to interact with the source data.
    source_type: IncludeOptions = "ALL",

    /// Defines how to interact with the profiles found in the current filtering.
    @"type": IncludeOptions = "ALL",

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .source_segments = "SourceSegments",
        .source_type = "SourceType",
        .@"type" = "Type",
    };
};
