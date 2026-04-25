const aws = @import("aws");

/// A segment update to apply during a mapping update operation.
pub const StartNetworkMigrationMappingUpdateSegment = struct {
    /// The updated scope tags for the segment.
    scope_tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the segment to update.
    segment_id: []const u8,

    /// The updated target AWS account for the segment.
    target_account: ?[]const u8 = null,

    pub const json_field_names = .{
        .scope_tags = "scopeTags",
        .segment_id = "segmentID",
        .target_account = "targetAccount",
    };
};
