/// Contains information about self-hosted AI resources and their host
/// resources. The fields that are present depend on the role of the resource.
///
/// On a self-hosted AI resource (a resource with a `SelfHosted::AI::` resource
/// type, such as `SelfHosted::AI::Model` or `SelfHosted::AI::Agent`), the
/// `HostResourceGuid` and `HostResourceType` fields link the resource to its
/// host. The `CanonicalId` field identifies what the resource is, enabling
/// aggregation of identical resources across multiple hosts.
///
/// On a host resource (such as an Amazon EC2 instance), the
/// `SelfHostedAI*ResourceCount` fields contain the count for each
/// `ResourceSubCategory` and the total count of self-hosted AI resources
/// detected on the host.
pub const AIDetails = struct {
    /// The canonical identifier for the AI resource, independent of where it is
    /// deployed. Multiple occurrences of the same resource on different hosts share
    /// the same `CanonicalId`. For model resources, the value follows the format
    /// `model/`, such as `model/pkg:huggingface/meta-llama/llama-3-8b`. Present
    /// only on self-hosted AI resources.
    canonical_id: ?[]const u8 = null,

    /// The identifier of the host resource that hosts the self-hosted AI resource.
    /// Present only on self-hosted AI resources.
    host_resource_guid: ?[]const u8 = null,

    /// The `ResourceType` of the host resource that hosts the self-hosted AI
    /// resource, such as `AWS::EC2::Instance`. Present only on self-hosted AI
    /// resources.
    host_resource_type: ?[]const u8 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `AgentFramework` detected on the host resource. Present only on host
    /// resources.
    self_hosted_ai_agent_framework_resource_count: ?i32 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `Agent` detected on the host resource. Present only on host resources.
    self_hosted_ai_agent_resource_count: ?i32 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `AgentToolsAndIdentity` detected on the host resource. Present only on host
    /// resources.
    self_hosted_ai_agent_tools_and_identity_resource_count: ?i32 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `Development` detected on the host resource. Present only on host resources.
    self_hosted_ai_development_resource_count: ?i32 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `ExternalEndpoint` detected on the host resource. Present only on host
    /// resources.
    self_hosted_ai_external_endpoint_resource_count: ?i32 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `Model` detected on the host resource. Present only on host resources.
    self_hosted_ai_model_resource_count: ?i32 = null,

    /// The number of self-hosted AI resources of `ResourceSubCategory`
    /// `ModelServing` detected on the host resource. Present only on host
    /// resources.
    self_hosted_ai_model_serving_resource_count: ?i32 = null,

    /// The total number of all self-hosted AI resources detected on the host
    /// resource. Present only on host resources.
    self_hosted_total_ai_resource_count: ?i32 = null,

    pub const json_field_names = .{
        .canonical_id = "CanonicalId",
        .host_resource_guid = "HostResourceGuid",
        .host_resource_type = "HostResourceType",
        .self_hosted_ai_agent_framework_resource_count = "SelfHostedAIAgentFrameworkResourceCount",
        .self_hosted_ai_agent_resource_count = "SelfHostedAIAgentResourceCount",
        .self_hosted_ai_agent_tools_and_identity_resource_count = "SelfHostedAIAgentToolsAndIdentityResourceCount",
        .self_hosted_ai_development_resource_count = "SelfHostedAIDevelopmentResourceCount",
        .self_hosted_ai_external_endpoint_resource_count = "SelfHostedAIExternalEndpointResourceCount",
        .self_hosted_ai_model_resource_count = "SelfHostedAIModelResourceCount",
        .self_hosted_ai_model_serving_resource_count = "SelfHostedAIModelServingResourceCount",
        .self_hosted_total_ai_resource_count = "SelfHostedTotalAIResourceCount",
    };
};
