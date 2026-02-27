const ClassificationScopeUpdateOperation = @import("classification_scope_update_operation.zig").ClassificationScopeUpdateOperation;

/// Specifies S3 buckets to add or remove from the exclusion list defined by the
/// classification scope for an Amazon Macie account.
pub const S3ClassificationScopeExclusionUpdate = struct {
    /// Depending on the value specified for the update operation
    /// (ClassificationScopeUpdateOperation), an array of strings that: lists the
    /// names of buckets to add or remove from the list, or specifies a new set of
    /// bucket names that overwrites all existing names in the list. Each string
    /// must be the full name of an existing S3 bucket. Values are case sensitive.
    bucket_names: []const []const u8,

    /// Specifies how to apply the changes to the exclusion list. Valid values are:
    ///
    /// * ADD - Append the specified bucket names to the current list.
    /// * REMOVE - Remove the specified bucket names from the current list.
    /// * REPLACE - Overwrite the current list with the specified list of bucket
    ///   names. If you specify this value, Amazon Macie removes all existing names
    ///   from the list and adds all the specified names to the list.
    operation: ClassificationScopeUpdateOperation,

    pub const json_field_names = .{
        .bucket_names = "bucketNames",
        .operation = "operation",
    };
};
