const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const MetricsConfiguration = @import("metrics_configuration.zig").MetricsConfiguration;
const SystemInstanceSummary = @import("system_instance_summary.zig").SystemInstanceSummary;
const DependencyRevision = @import("dependency_revision.zig").DependencyRevision;

/// An object that contains a system instance definition and summary
/// information.
pub const SystemInstanceDescription = struct {
    definition: ?DefinitionDocument,

    /// The AWS Identity and Access Management (IAM) role that AWS IoT Things Graph
    /// assumes during flow execution in a
    /// cloud deployment. This role must have read and write permissionss to AWS
    /// Lambda and AWS IoT and to any other
    /// AWS services that the flow uses.
    flow_actions_role_arn: ?[]const u8,

    metrics_configuration: ?MetricsConfiguration,

    /// The Amazon Simple Storage Service bucket where information about a system
    /// instance is stored.
    s_3_bucket_name: ?[]const u8,

    /// An object that contains summary information about a system instance.
    summary: ?SystemInstanceSummary,

    /// A list of objects that contain all of the IDs and revision numbers of
    /// workflows and systems that are used in a system instance.
    validated_dependency_revisions: ?[]const DependencyRevision,

    /// The version of the user's namespace against which the system instance was
    /// validated.
    validated_namespace_version: ?i64,

    pub const json_field_names = .{
        .definition = "definition",
        .flow_actions_role_arn = "flowActionsRoleArn",
        .metrics_configuration = "metricsConfiguration",
        .s_3_bucket_name = "s3BucketName",
        .summary = "summary",
        .validated_dependency_revisions = "validatedDependencyRevisions",
        .validated_namespace_version = "validatedNamespaceVersion",
    };
};
