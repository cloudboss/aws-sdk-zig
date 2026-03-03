pub const Concurrency = struct {
    /// The number of concurrent executions that are reserved for this function. For
    /// more information, see [Managing Lambda reserved
    /// concurrency](https://docs.aws.amazon.com/lambda/latest/dg/configuration-concurrency.html).
    reserved_concurrent_executions: ?i32 = null,

    pub const json_field_names = .{
        .reserved_concurrent_executions = "ReservedConcurrentExecutions",
    };
};
