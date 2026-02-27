/// Enum representing the invocation state of an agent alias
pub const AliasInvocationState = enum {
    /// Agent is actively processing requests
    accept_invocations,
    /// Agent is paused and will not accept new requests
    reject_invocations,

    pub const json_field_names = .{
        .accept_invocations = "ACCEPT_INVOCATIONS",
        .reject_invocations = "REJECT_INVOCATIONS",
    };
};
