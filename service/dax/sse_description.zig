const SSEStatus = @import("sse_status.zig").SSEStatus;

/// The description of the server-side encryption status on the specified DAX
/// cluster.
pub const SSEDescription = struct {
    /// The current state of server-side encryption:
    ///
    /// * `ENABLING` - Server-side encryption is being enabled.
    ///
    /// * `ENABLED` - Server-side encryption is enabled.
    ///
    /// * `DISABLING` - Server-side encryption is being disabled.
    ///
    /// * `DISABLED` - Server-side encryption is disabled.
    status: ?SSEStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
