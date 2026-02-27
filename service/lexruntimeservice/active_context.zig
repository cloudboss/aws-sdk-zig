const aws = @import("aws");

const ActiveContextTimeToLive = @import("active_context_time_to_live.zig").ActiveContextTimeToLive;

/// A context is a variable that contains information about the current
/// state of the conversation between a user and Amazon Lex. Context can be set
/// automatically by Amazon Lex when an intent is fulfilled, or it can be set at
/// runtime using the `PutContent`, `PutText`, or
/// `PutSession` operation.
pub const ActiveContext = struct {
    /// The name of the context.
    name: []const u8,

    /// State variables for the current context. You can use these values as
    /// default values for slots in subsequent events.
    parameters: []const aws.map.StringMapEntry,

    /// The length of time or number of turns that a context remains
    /// active.
    time_to_live: ActiveContextTimeToLive,

    pub const json_field_names = .{
        .name = "name",
        .parameters = "parameters",
        .time_to_live = "timeToLive",
    };
};
