/// Information about why a request was throttled.
pub const ThrottlingReason = struct {
    /// The reason that the request was throttled.
    reason: ?[]const u8 = null,

    /// The resource that caused the request to be throttled.
    resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .reason = "reason",
        .resource = "resource",
    };
};
