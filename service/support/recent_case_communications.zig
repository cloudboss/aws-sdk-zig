const Communication = @import("communication.zig").Communication;

/// The five most recent communications associated with the case.
pub const RecentCaseCommunications = struct {
    /// The five most recent communications associated with the case.
    communications: ?[]const Communication,

    /// A resumption point for pagination.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .communications = "communications",
        .next_token = "nextToken",
    };
};
