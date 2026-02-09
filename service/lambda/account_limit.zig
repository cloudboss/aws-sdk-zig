/// Limits that are related to concurrency and storage. All file and storage
/// sizes are in bytes.
pub const AccountLimit = struct {
    /// The maximum size of a function's deployment package and layers when they're
    /// extracted.
    code_size_unzipped: ?i64,

    /// The maximum size of a deployment package when it's uploaded directly to
    /// Lambda. Use Amazon S3 for larger files.
    code_size_zipped: ?i64,

    /// The maximum number of simultaneous function executions.
    concurrent_executions: ?i32,

    /// The amount of storage space that you can use for all deployment packages and
    /// layer archives.
    total_code_size: ?i64,

    /// The maximum number of simultaneous function executions, minus the capacity
    /// that's reserved for individual functions with PutFunctionConcurrency.
    unreserved_concurrent_executions: ?i32,
};
