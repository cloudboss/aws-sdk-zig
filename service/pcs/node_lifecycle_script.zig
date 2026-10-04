const ExecutionPolicy = @import("execution_policy.zig").ExecutionPolicy;
const OnError = @import("on_error.zig").OnError;
const ScriptSource = @import("script_source.zig").ScriptSource;

/// A script to run during a compute node lifecycle stage.
pub const NodeLifecycleScript = struct {
    /// The command-line arguments to pass to the script. You can specify up to 20
    /// arguments, and each argument can be up to 256 characters long.
    arguments: ?[]const []const u8 = null,

    /// The policy that determines when the script runs. The default value is
    /// `FIRST_BOOT_ONLY`. Valid values:
    ///
    /// * `FIRST_BOOT_ONLY` – Runs the script only the first time the compute node
    ///   boots.
    /// * `EVERY_BOOT` – Runs the script every time the compute node boots,
    ///   including reboots.
    execution_policy: ExecutionPolicy = .first_boot_only,

    /// A unique name for the script. The name can be up to 64 characters long.
    /// Valid characters are letters, numbers, spaces, underscores (`_`), and
    /// hyphens (`-`). The first character must be a letter or a number.
    name: []const u8,

    /// The behavior when the script fails. The default value is `TERMINATE`. Valid
    /// values:
    ///
    /// * `TERMINATE` – Terminates the compute node.
    /// * `STOP_SEQUENCE` – Stops running subsequent scripts in the sequence but
    ///   doesn't terminate the compute node.
    /// * `CONTINUE` – Ignores the error and continues running the next script.
    on_error: OnError = .terminate,

    /// The source location and integrity information for the script.
    script_source: ScriptSource,

    pub const json_field_names = .{
        .arguments = "arguments",
        .execution_policy = "executionPolicy",
        .name = "name",
        .on_error = "onError",
        .script_source = "scriptSource",
    };
};
