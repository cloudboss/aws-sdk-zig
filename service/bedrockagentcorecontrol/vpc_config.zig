/// VpcConfig for the Agent.
pub const VpcConfig = struct {
    /// This field applies only to Agent Runtimes. It is not applicable to Browsers
    /// or Code Interpreters.
    ///
    /// Controls whether a service-managed Amazon S3 gateway endpoint is provisioned
    /// in the VPC network topology for the agent runtime. This gateway is used by
    /// Amazon Bedrock AgentCore Runtime to download code and container images
    /// during agent startup.
    ///
    /// Starting May 5, 2026, Amazon Bedrock AgentCore Runtime is gradually rolling
    /// out a change to how network isolation is configured for VPC mode agents.
    /// Agent runtimes created on or after this rollout will no longer include the
    /// service-managed Amazon S3 gateway. Instead, all network access, including to
    /// Amazon S3, is governed exclusively by your VPC configuration. This field
    /// cannot be set on agent runtimes created after the rollout. Passing this
    /// field in an `UpdateAgentRuntime` request for these agent runtimes returns a
    /// `ValidationException`.
    ///
    /// Agent runtimes created before the rollout are not affected and continue to
    /// operate with the service-managed Amazon S3 gateway. To enforce full VPC
    /// network isolation on these existing agent runtimes, set this field to
    /// `false` via the `UpdateAgentRuntime` API. Before opting out, ensure your VPC
    /// provides the Amazon S3 access required for agent startup. If this field is
    /// not specified or is set to `true`, the service-managed Amazon S3 gateway
    /// remains provisioned.
    ///
    /// This field is only supported in the `UpdateAgentRuntime` API for pre-rollout
    /// agent runtimes. Passing this field in a `CreateAgentRuntime` request returns
    /// a `ValidationException`.
    require_service_s3_endpoint: ?bool = null,

    /// The security groups associated with the VPC configuration.
    security_groups: []const []const u8,

    /// The subnets associated with the VPC configuration.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .require_service_s3_endpoint = "requireServiceS3Endpoint",
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
