const ServerProcess = @import("server_process.zig").ServerProcess;

/// A set of instructions that define the set of server processes to run on
/// computes in a
/// fleet. Server processes run either an executable in a custom game build or a
/// Amazon GameLift Servers Realtime
/// script. Amazon GameLift Servers launches the processes, manages their life
/// cycle, and replaces them as
/// needed. Computes check regularly for an updated runtime configuration.
///
/// An Amazon GameLift Servers instance is limited to 50 processes running
/// concurrently. To calculate the
/// total number of processes defined in a runtime configuration, add the values
/// of the
/// `ConcurrentExecutions` parameter for each server process. Learn more
/// about [ Running Multiple
/// Processes on a
/// Fleet](https://docs.aws.amazon.com/gamelift/latest/developerguide/fleets-multiprocess.html).
pub const RuntimeConfiguration = struct {
    /// The maximum amount of time (in seconds) allowed to launch a new game session
    /// and have
    /// it report ready to host players. During this time, the game session is in
    /// status
    /// `ACTIVATING`. If the game session does not become active before the
    /// timeout, it is ended and the game session status is changed to
    /// `TERMINATED`.
    game_session_activation_timeout_seconds: ?i32 = null,

    /// The number of game sessions in status `ACTIVATING` to allow on an
    /// instance or compute. This setting limits the instance resources that can be
    /// used for new game activations at any one time.
    max_concurrent_game_session_activations: ?i32 = null,

    /// A collection of server process configurations that identify what server
    /// processes to
    /// run on fleet computes.
    server_processes: ?[]const ServerProcess = null,

    pub const json_field_names = .{
        .game_session_activation_timeout_seconds = "GameSessionActivationTimeoutSeconds",
        .max_concurrent_game_session_activations = "MaxConcurrentGameSessionActivations",
        .server_processes = "ServerProcesses",
    };
};
