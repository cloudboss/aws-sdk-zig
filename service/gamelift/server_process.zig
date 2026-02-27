/// A set of instructions for launching server processes on fleet computes.
/// Server
/// processes run either an executable in a custom game build or a Amazon
/// GameLift Servers Realtime script. Server
/// process configurations are part of a fleet's runtime configuration.
pub const ServerProcess = struct {
    /// The number of server processes using this configuration that run
    /// concurrently on each
    /// instance or compute.
    concurrent_executions: i32,

    /// The location of a game build executable or Realtime script. Game builds and
    /// Realtime
    /// scripts are installed on instances at the root:
    ///
    /// * Windows (custom game builds only): `C:\game`. Example:
    /// "`C:\game\MyGame\server.exe`"
    ///
    /// * Linux: `/local/game`. Examples:
    /// "`/local/game/MyGame/server.exe`" or
    /// "`/local/game/MyRealtimeScript.js`"
    ///
    /// Amazon GameLift Servers doesn't support the use of setup scripts that launch
    /// the game executable.
    /// For custom game builds, this parameter must indicate the executable that
    /// calls the
    /// server SDK operations `initSDK()` and `ProcessReady()`.
    launch_path: []const u8,

    /// An optional list of parameters to pass to the server executable or Realtime
    /// script on
    /// launch.
    parameters: ?[]const u8,

    pub const json_field_names = .{
        .concurrent_executions = "ConcurrentExecutions",
        .launch_path = "LaunchPath",
        .parameters = "Parameters",
    };
};
