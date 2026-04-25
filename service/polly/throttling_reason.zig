/// Provides information about a specific throttling reason.
pub const ThrottlingReason = struct {
    /// The reason code explaining why the request was throttled.
    reason: ?[]const u8 = null,

    /// The resource that caused the throttling.
    resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .reason = "reason",
        .resource = "resource",
    };
};
