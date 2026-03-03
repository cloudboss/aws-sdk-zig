const ServiceId = @import("service_id.zig").ServiceId;

/// Information about a user recorded in segment documents.
pub const TraceUser = struct {
    /// Services that the user's request hit.
    service_ids: ?[]const ServiceId = null,

    /// The user's name.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_ids = "ServiceIds",
        .user_name = "UserName",
    };
};
