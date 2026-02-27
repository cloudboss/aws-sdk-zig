const MergeType = @import("merge_type.zig").MergeType;

/// Describes properties used to specify configurations related to a source API.
pub const SourceApiAssociationConfig = struct {
    /// The property that indicates which merging option is enabled in the source
    /// API
    /// association.
    ///
    /// Valid merge types are `MANUAL_MERGE` (default) and `AUTO_MERGE`.
    /// Manual merges are the default behavior and require the user to trigger any
    /// changes from the
    /// source APIs to the merged API manually. Auto merges subscribe the merged API
    /// to the changes
    /// performed on the source APIs so that any change in the source APIs are also
    /// made to the
    /// merged API. Auto merges use `MergedApiExecutionRoleArn` to perform merge
    /// operations.
    merge_type: ?MergeType,

    pub const json_field_names = .{
        .merge_type = "mergeType",
    };
};
