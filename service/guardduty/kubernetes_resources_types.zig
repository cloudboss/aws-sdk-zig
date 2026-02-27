pub const KubernetesResourcesTypes = enum {
    pods,
    jobs,
    cronjobs,
    deployments,
    daemonsets,
    statefulsets,
    replicasets,
    replicationcontrollers,

    pub const json_field_names = .{
        .pods = "PODS",
        .jobs = "JOBS",
        .cronjobs = "CRONJOBS",
        .deployments = "DEPLOYMENTS",
        .daemonsets = "DAEMONSETS",
        .statefulsets = "STATEFULSETS",
        .replicasets = "REPLICASETS",
        .replicationcontrollers = "REPLICATIONCONTROLLERS",
    };
};
