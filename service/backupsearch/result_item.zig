const EBSResultItem = @import("ebs_result_item.zig").EBSResultItem;
const S3ResultItem = @import("s3_result_item.zig").S3ResultItem;

/// This is an object representing the item returned in the results of a search
/// for a specific resource type.
pub const ResultItem = union(enum) {
    /// These are items returned in the search results of an Amazon EBS search.
    ebs_result_item: ?EBSResultItem,
    /// These are items returned in the search results of an Amazon S3 search.
    s3_result_item: ?S3ResultItem,

    pub const json_field_names = .{
        .ebs_result_item = "EBSResultItem",
        .s3_result_item = "S3ResultItem",
    };
};
