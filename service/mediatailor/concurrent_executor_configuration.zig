const aws = @import("aws");

const FunctionRef = @import("function_ref.zig").FunctionRef;
const RuntimeType = @import("runtime_type.zig").RuntimeType;

/// The configuration for a `CONCURRENT_EXECUTOR` function. A
/// `CONCURRENT_EXECUTOR` runs a set of child functions in parallel, up to a
/// maximum concurrency, and combines their output when all functions complete.
/// For more information about functions, see [Working with
/// functions](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions.html) in the *MediaTailor User Guide*.
pub const ConcurrentExecutorConfiguration = struct {
    /// The list of child functions that MediaTailor runs in parallel. Each entry
    /// specifies a child function to execute and an optional run condition
    /// expression that controls whether the function runs.
    function_list: []const FunctionRef,

    /// The maximum number of child functions that MediaTailor runs simultaneously.
    /// When the list contains more functions than `MaxConcurrency`, MediaTailor
    /// starts additional functions as running ones complete, so that no more than
    /// `MaxConcurrency` functions run at the same time.
    max_concurrency: i32,

    /// A map of output bindings that controls which bindings the executor commits
    /// to the session state after all child functions complete. Each key is a
    /// namespaced output path, and each value is an expression that MediaTailor
    /// evaluates against the combined results of the child functions.
    output: []const aws.map.StringMapEntry,

    /// The expression language used to evaluate expressions in the function
    /// configuration. Set this to `JSONata`.
    runtime: RuntimeType,

    /// The maximum time, in milliseconds, for all child functions to complete. This
    /// timeout covers every function in the list, including any HTTP calls the
    /// child functions make. If the executor exceeds this timeout, MediaTailor
    /// discards all output from the executor and proceeds with default behavior.
    timeout_milliseconds: i32,

    pub const json_field_names = .{
        .function_list = "FunctionList",
        .max_concurrency = "MaxConcurrency",
        .output = "Output",
        .runtime = "Runtime",
        .timeout_milliseconds = "TimeoutMilliseconds",
    };
};
