const aws = @import("aws");

const ActiveContext = @import("active_context.zig").ActiveContext;
const RuntimeHints = @import("runtime_hints.zig").RuntimeHints;

/// Specifications for the current state of the dialog
/// between the user and the bot in the test set.
pub const InputSessionStateSpecification = struct {
    /// Active contexts for the session state.
    active_contexts: ?[]const ActiveContext = null,

    /// Runtime hints for the session state.
    runtime_hints: ?RuntimeHints = null,

    /// Session attributes for the session state.
    session_attributes: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .runtime_hints = "runtimeHints",
        .session_attributes = "sessionAttributes",
    };
};
