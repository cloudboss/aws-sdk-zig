pub const ReportInstanceReasonCodes = enum {
    instance_stuck_in_state,
    unresponsive,
    not_accepting_credentials,
    password_not_available,
    performance_network,
    performance_instance_store,
    performance_ebs_volume,
    performance_other,
    other,
};
