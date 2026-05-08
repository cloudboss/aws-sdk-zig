const aws = @import("aws");

const FunctionRef = @import("function_ref.zig").FunctionRef;
const RuntimeType = @import("runtime_type.zig").RuntimeType;

/// The configuration for a `SEQUENTIAL_EXECUTOR` function. A
/// `SEQUENTIAL_EXECUTOR` runs a sequence of child functions in order, passing
/// data between steps through temporary data. For more information, see
/// [SEQUENTIAL_EXECUTOR](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-types-sequential-executor.html) in the *MediaTailor User Guide*.
pub const SequentialExecutorConfiguration = struct {
    /// An ordered list of 1 to 10 steps. Each step specifies a child function to
    /// execute and an optional run condition expression that controls whether the
    /// step runs. MediaTailor executes steps in order, passing data between steps
    /// through temporary data.
    function_list: []const FunctionRef,

    /// An optional map of output bindings that controls which bindings the sequence
    /// commits to the session state after all steps complete. If omitted,
    /// MediaTailor commits all accumulated output bindings from all child steps.
    output: ?[]const aws.map.StringMapEntry = null,

    /// The expression language used to evaluate expressions in the function
    /// configuration. Set this to `JSONata`.
    runtime: RuntimeType,

    /// The maximum time, in milliseconds, for the entire sequence to complete. This
    /// timeout covers all steps, including any HTTP calls made by child functions.
    /// If the sequence exceeds this timeout, MediaTailor discards all output from
    /// the sequence and proceeds with default behavior.
    timeout_milliseconds: i32,

    pub const json_field_names = .{
        .function_list = "FunctionList",
        .output = "Output",
        .runtime = "Runtime",
        .timeout_milliseconds = "TimeoutMilliseconds",
    };
};
