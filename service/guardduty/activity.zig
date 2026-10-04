const ApiCall = @import("api_call.zig").ApiCall;
const ActivityType = @import("activity_type.zig").ActivityType;

/// Contains information about an activity, such as an API call, that was
/// observed for a signal.
pub const Activity = struct {
    /// Contains information about the API call that was observed, when the activity
    /// type is `API_CALL`.
    api: ?ApiCall = null,

    /// The type of the observed activity.
    @"type": ActivityType,

    pub const json_field_names = .{
        .api = "Api",
        .@"type" = "Type",
    };
};
