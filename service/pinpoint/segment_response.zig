const aws = @import("aws");

const SegmentDimensions = @import("segment_dimensions.zig").SegmentDimensions;
const SegmentImportResource = @import("segment_import_resource.zig").SegmentImportResource;
const SegmentGroupList = @import("segment_group_list.zig").SegmentGroupList;
const SegmentType = @import("segment_type.zig").SegmentType;

/// Provides information about the configuration, dimension, and other settings
/// for a segment.
pub const SegmentResponse = struct {
    /// The unique identifier for the application that the segment is associated
    /// with.
    application_id: []const u8,

    /// The Amazon Resource Name (ARN) of the segment.
    arn: []const u8,

    /// The date and time when the segment was created.
    creation_date: []const u8,

    /// The dimension settings for the segment.
    dimensions: ?SegmentDimensions = null,

    /// The unique identifier for the segment.
    id: []const u8,

    /// The settings for the import job that's associated with the segment.
    import_definition: ?SegmentImportResource = null,

    /// The date and time when the segment was last modified.
    last_modified_date: ?[]const u8 = null,

    /// The name of the segment.
    name: ?[]const u8 = null,

    /// A list of one or more segment groups that apply to the segment. Each segment
    /// group consists of zero or more base segments and the dimensions that are
    /// applied to those base segments.
    segment_groups: ?SegmentGroupList = null,

    /// The segment type. Valid values are:
    ///
    /// * DIMENSIONAL - A dynamic segment, which is a segment that uses selection
    ///   criteria that you specify and is based on endpoint data that's reported by
    ///   your app. Dynamic segments can change over time.
    /// * IMPORT - A static segment, which is a segment that uses selection criteria
    ///   that you specify and is based on endpoint definitions that you import from
    ///   a file. Imported segments are static; they don't change over time.
    segment_type: SegmentType,

    /// A string-to-string map of key-value pairs that identifies the tags that are
    /// associated with the segment. Each tag consists of a required tag key and an
    /// associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The version number of the segment.
    version: ?i32 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .creation_date = "CreationDate",
        .dimensions = "Dimensions",
        .id = "Id",
        .import_definition = "ImportDefinition",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .segment_groups = "SegmentGroups",
        .segment_type = "SegmentType",
        .tags = "tags",
        .version = "Version",
    };
};
