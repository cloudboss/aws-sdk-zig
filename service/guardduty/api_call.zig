/// Contains information about an API call that was observed as part of an
/// activity.
pub const ApiCall = struct {
    /// The error code that was returned, if the API call failed.
    @"error": ?[]const u8 = null,

    /// The name of the API operation that was invoked.
    operation: ?[]const u8 = null,

    /// The service that the API operation was invoked against.
    service: ?[]const u8 = null,

    /// User agent in the request to the API operation
    user_agent: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .operation = "Operation",
        .service = "Service",
        .user_agent = "UserAgent",
    };
};
