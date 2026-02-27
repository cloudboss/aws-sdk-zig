const aws = @import("aws");

const SegmentDimensions = @import("segment_dimensions.zig").SegmentDimensions;
const SegmentGroupList = @import("segment_group_list.zig").SegmentGroupList;

/// Specifies the configuration, dimension, and other settings for a segment. A
/// WriteSegmentRequest object can include a Dimensions object or a
/// SegmentGroups object, but not both.
pub const WriteSegmentRequest = struct {
    /// The criteria that define the dimensions for the segment.
    dimensions: ?SegmentDimensions,

    /// The name of the segment.
    name: ?[]const u8,

    /// The segment group to use and the dimensions to apply to the group's base
    /// segments in order to build the segment. A segment group can consist of zero
    /// or more base segments. Your request can include only one segment group.
    segment_groups: ?SegmentGroupList,

    /// As of **22-05-2023** tags has been deprecated for update operations. After
    /// this date any value in tags is not processed and an error code is not
    /// returned. To manage tags we recommend using either
    /// [Tags](https://docs.aws.amazon.com/pinpoint/latest/apireference/tags-resource-arn.html) in the *API Reference for Amazon Pinpoint*, [resourcegroupstaggingapi](https://docs.aws.amazon.com/cli/latest/reference/resourcegroupstaggingapi/index.html) commands in the *AWS Command Line Interface Documentation* or [resourcegroupstaggingapi](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/resourcegroupstaggingapi/package-summary.html) in the *AWS SDK*.
    ///
    /// (Deprecated) A string-to-string map of key-value pairs that defines the tags
    /// to associate with the segment. Each tag consists of a required tag key and
    /// an associated tag value.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .name = "Name",
        .segment_groups = "SegmentGroups",
        .tags = "tags",
    };
};
