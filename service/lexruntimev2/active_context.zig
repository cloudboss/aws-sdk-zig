const aws = @import("aws");

const ActiveContextTimeToLive = @import("active_context_time_to_live.zig").ActiveContextTimeToLive;

/// Contains information about the contexts that a user is using in a
/// session. You can configure Amazon Lex V2 to set a context when an intent is
/// fulfilled, or you can set a context using the , , or operations.
///
/// Use a context to indicate to Amazon Lex V2 intents that should be used as
/// follow-up intents. For example, if the active context is
/// `order-fulfilled`, only intents that have
/// `order-fulfilled` configured as a trigger are considered
/// for follow up.
pub const ActiveContext = struct {
    /// A list of contexts active for the request. A context can be
    /// activated when a previous intent is fulfilled, or by including the
    /// context in the request.
    ///
    /// If you don't specify a list of contexts, Amazon Lex V2 will use the current
    /// list of contexts for the session. If you specify an empty list, all
    /// contexts for the session are cleared.
    context_attributes: []const aws.map.StringMapEntry,

    /// The name of the context.
    name: []const u8,

    /// Indicates the number of turns or seconds that the context is active.
    /// Once the time to live expires, the context is no longer returned in a
    /// response.
    time_to_live: ActiveContextTimeToLive,

    pub const json_field_names = .{
        .context_attributes = "contextAttributes",
        .name = "name",
        .time_to_live = "timeToLive",
    };
};
