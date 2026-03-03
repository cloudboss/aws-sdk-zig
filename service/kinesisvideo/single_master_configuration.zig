/// A structure that contains the configuration for the `SINGLE_MASTER` channel
/// type.
pub const SingleMasterConfiguration = struct {
    /// The period of time (in seconds) a signaling channel retains undelivered
    /// messages
    /// before they are discarded. Use to update
    /// this value.
    message_ttl_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message_ttl_seconds = "MessageTtlSeconds",
    };
};
