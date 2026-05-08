const aws = @import("aws");

const RuntimeType = @import("runtime_type.zig").RuntimeType;

/// The configuration for a `CUSTOM_OUTPUT` function. MediaTailor evaluates the
/// output expressions against the current session state and commits the results
/// as output bindings. `CUSTOM_OUTPUT` functions do not make external calls.
/// For more information, see
/// [CUSTOM_OUTPUT](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-types-custom-output.html) in the *MediaTailor User Guide*.
pub const CustomOutputConfiguration = struct {
    /// A map of output bindings. Each key is a namespaced output path (such as
    /// `player_params.device_type` or `temp.variant`), and each value is an
    /// expression that MediaTailor evaluates at runtime against the current session
    /// state. For more information about expression syntax, see [JSONata expression
    /// reference](https://docs.aws.amazon.com/mediatailor/latest/ug/monetization-functions-jsonata.html) in the *MediaTailor User Guide*.
    output: ?[]const aws.map.StringMapEntry = null,

    /// The expression language used to evaluate expressions in the function
    /// configuration. Set this to `JSONata`.
    runtime: RuntimeType,

    pub const json_field_names = .{
        .output = "Output",
        .runtime = "Runtime",
    };
};
