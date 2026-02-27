/// Details about the state of a replicator
pub const ReplicationStateInfo = struct {
    /// Code that describes the current state of the replicator.
    code: ?[]const u8,

    /// Message that describes the state of the replicator.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
