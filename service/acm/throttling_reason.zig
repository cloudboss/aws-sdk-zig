/// A description of why a request was throttled.
pub const ThrottlingReason = struct {
    /// A description of why a request was throttled.
    reason: ?[]const u8 = null,

    /// The resource that causes the request to be throttled.
    resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .reason = "reason",
        .resource = "resource",
    };
};
