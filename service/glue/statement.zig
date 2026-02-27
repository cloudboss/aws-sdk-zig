const StatementOutput = @import("statement_output.zig").StatementOutput;
const StatementState = @import("statement_state.zig").StatementState;

/// The statement or request for a particular action to occur in a session.
pub const Statement = struct {
    /// The execution code of the statement.
    code: ?[]const u8,

    /// The unix time and date that the job definition was completed.
    completed_on: i64 = 0,

    /// The ID of the statement.
    id: i32 = 0,

    /// The output in JSON.
    output: ?StatementOutput,

    /// The code execution progress.
    progress: f64 = 0,

    /// The unix time and date that the job definition was started.
    started_on: i64 = 0,

    /// The state while request is actioned.
    state: ?StatementState,

    pub const json_field_names = .{
        .code = "Code",
        .completed_on = "CompletedOn",
        .id = "Id",
        .output = "Output",
        .progress = "Progress",
        .started_on = "StartedOn",
        .state = "State",
    };
};
