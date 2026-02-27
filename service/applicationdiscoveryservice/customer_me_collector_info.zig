/// The inventory data for installed Migration Evaluator collectors.
pub const CustomerMeCollectorInfo = struct {
    /// The number of active Migration Evaluator collectors.
    active_me_collectors: i32 = 0,

    /// The number of deny-listed Migration Evaluator collectors.
    deny_listed_me_collectors: i32 = 0,

    /// The number of healthy Migration Evaluator collectors.
    healthy_me_collectors: i32 = 0,

    /// The number of Migration Evaluator collectors with `SHUTDOWN` status.
    shutdown_me_collectors: i32 = 0,

    /// The total number of Migration Evaluator collectors.
    total_me_collectors: i32 = 0,

    /// The number of unhealthy Migration Evaluator collectors.
    unhealthy_me_collectors: i32 = 0,

    /// The number of unknown Migration Evaluator collectors.
    unknown_me_collectors: i32 = 0,

    pub const json_field_names = .{
        .active_me_collectors = "activeMeCollectors",
        .deny_listed_me_collectors = "denyListedMeCollectors",
        .healthy_me_collectors = "healthyMeCollectors",
        .shutdown_me_collectors = "shutdownMeCollectors",
        .total_me_collectors = "totalMeCollectors",
        .unhealthy_me_collectors = "unhealthyMeCollectors",
        .unknown_me_collectors = "unknownMeCollectors",
    };
};
