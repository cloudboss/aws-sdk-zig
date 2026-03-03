const Step = @import("step.zig").Step;

/// Latest routing criteria on the contact.
pub const RoutingCriteria = struct {
    /// The timestamp indicating when the routing criteria is set to active. A
    /// routing criteria is activated when
    /// contact is transferred to a queue. ActivationTimestamp will be set on
    /// routing criteria for contacts in agent queue
    /// even though Routing criteria is never activated for contacts in agent queue.
    activation_timestamp: ?i64 = null,

    /// Information about the index of the routing criteria.
    index: ?i32 = null,

    /// List of routing steps. When Amazon Connect does not find an available agent
    /// meeting the requirements in a
    /// step for a given step duration, the routing criteria will move on to the
    /// next step sequentially until a join is
    /// completed with an agent. When all steps are exhausted, the contact will be
    /// offered to any agent in the queue.
    steps: ?[]const Step = null,

    pub const json_field_names = .{
        .activation_timestamp = "ActivationTimestamp",
        .index = "Index",
        .steps = "Steps",
    };
};
