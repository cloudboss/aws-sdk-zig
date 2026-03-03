const Status = @import("status.zig").Status;

/// Options for filtering API keys.
pub const ApiKeyFilter = struct {
    /// Filter on `Active` or `Expired` API keys.
    key_status: ?Status = null,

    pub const json_field_names = .{
        .key_status = "KeyStatus",
    };
};
