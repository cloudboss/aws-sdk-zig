const HostingEnvironment = @import("hosting_environment.zig").HostingEnvironment;

/// The configuration that restricts which workloads in the request's identity
/// chain are allowed to invoke the target, identified by their hosting
/// environments and workload identities. At launch, this is supported only for
/// AgentCore Runtime targets, and the allowed workloads are AgentCore Gateways.
pub const AllowedWorkloadConfiguration = struct {
    /// The list of hosting environments whose workloads are allowed to invoke the
    /// target. At launch, the only supported hosting environment is AgentCore
    /// Gateway.
    hosting_environments: ?[]const HostingEnvironment = null,

    /// The list of workload identities that are allowed to invoke the target.
    workload_identities: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .hosting_environments = "hostingEnvironments",
        .workload_identities = "workloadIdentities",
    };
};
