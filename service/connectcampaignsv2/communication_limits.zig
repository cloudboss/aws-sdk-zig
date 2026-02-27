const CommunicationLimit = @import("communication_limit.zig").CommunicationLimit;

/// Communication limits
pub const CommunicationLimits = union(enum) {
    communication_limits_list: ?[]const CommunicationLimit,

    pub const json_field_names = .{
        .communication_limits_list = "communicationLimitsList",
    };
};
