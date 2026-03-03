const ResourceCountsSummary = @import("resource_counts_summary.zig").ResourceCountsSummary;

/// Summary counts of each Proton resource type.
pub const CountsSummary = struct {
    /// The total number of components in the Amazon Web Services account.
    ///
    /// The semantics of the `components` field are different from the semantics of
    /// results for other
    /// infrastructure-provisioning resources. That's because at this time
    /// components don't have associated templates,
    /// therefore they don't have the concept of staleness. The `components` object
    /// will only contain
    /// `total` and `failed` members.
    components: ?ResourceCountsSummary = null,

    /// The staleness counts for Proton environments in the Amazon Web Services
    /// account. The `environments` object will only
    /// contain `total` members.
    environments: ?ResourceCountsSummary = null,

    /// The total number of environment templates in the Amazon Web Services
    /// account. The `environmentTemplates` object
    /// will only contain `total` members.
    environment_templates: ?ResourceCountsSummary = null,

    /// The staleness counts for Proton pipelines in the Amazon Web Services
    /// account.
    pipelines: ?ResourceCountsSummary = null,

    /// The staleness counts for Proton service instances in the Amazon Web Services
    /// account.
    service_instances: ?ResourceCountsSummary = null,

    /// The staleness counts for Proton services in the Amazon Web Services account.
    services: ?ResourceCountsSummary = null,

    /// The total number of service templates in the Amazon Web Services account.
    /// The `serviceTemplates` object will only
    /// contain `total` members.
    service_templates: ?ResourceCountsSummary = null,

    pub const json_field_names = .{
        .components = "components",
        .environments = "environments",
        .environment_templates = "environmentTemplates",
        .pipelines = "pipelines",
        .service_instances = "serviceInstances",
        .services = "services",
        .service_templates = "serviceTemplates",
    };
};
