const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliverySource = @import("delivery_source.zig").DeliverySource;

pub const PutDeliverySourceInput = struct {
    /// A map of key-value pairs to configure the delivery source. Both keys and
    /// values must be
    /// between 1 and 255 characters in length. For example,
    /// `{"samplingRate": "50"}`.
    delivery_source_configuration: ?[]const aws.map.StringMapEntry = null,

    /// Defines the type of log that the source is sending.
    ///
    /// * For Amazon Web Services Amplify, the valid values are `ACCESS_LOGS` and
    /// `WAF_LOGS`.
    ///
    /// * For Application Load Balancer, the valid values are `ALB_ACCESS_LOGS`,
    /// `ALB_CONNECTION_LOGS`, and `ALB_HEALTH_CHECK_LOGS`.
    ///
    /// * For Amazon Bedrock AgentCore Gateway, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Identity, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Memory, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Payments, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Runtime, the valid values are
    /// `APPLICATION_LOGS`, `USAGE_LOGS`, and `TRACES`.
    ///
    /// * For Amazon Bedrock AgentCore Tools, the valid values are
    /// `APPLICATION_LOGS`, `USAGE_LOGS`, and `TRACES`.
    ///
    /// * For Amazon Bedrock Agents, the valid values are `APPLICATION_LOGS` and
    /// `EVENT_LOGS`.
    ///
    /// * For Amazon Bedrock Knowledge Bases, the valid values are
    /// `APPLICATION_LOGS` and `TRACES`.
    ///
    /// * For CloudFront, the valid value is `ACCESS_LOGS`.
    ///
    /// * For query execution logs from CloudWatch Logs Insights, the valid value is
    /// `INSIGHTS_QUERY_LOGS`.
    ///
    /// * For Amazon CodeWhisperer, the valid value is `EVENT_LOGS`.
    ///
    /// * For DevOps Agent, the valid value is `APPLICATION_LOGS`.
    ///
    /// * For Amazon EKS Auto Mode, the valid values are
    ///   `AUTO_MODE_BLOCK_STORAGE_LOGS`,
    /// `AUTO_MODE_COMPUTE_LOGS`, `AUTO_MODE_IPAM_LOGS`, and
    /// `AUTO_MODE_LOAD_BALANCING_LOGS`.
    ///
    /// * For Amazon EKS Capability Logs, the valid values are
    ///   `EKS_CAPABILITY_ACK_LOGS`,
    /// `EKS_CAPABILITY_ARGOCD_APPLICATION_LOGS`,
    /// `EKS_CAPABILITY_ARGOCD_APPLICATIONSET_LOGS`,
    /// `EKS_CAPABILITY_ARGOCD_COMMITSERVER_LOGS`,
    /// `EKS_CAPABILITY_ARGOCD_REPOSERVER_LOGS`,
    /// `EKS_CAPABILITY_ARGOCD_SERVER_LOGS`, and
    /// `EKS_CAPABILITY_KRO_LOGS`.
    ///
    /// * For Amazon Web Services Elemental Inference, the valid value is
    /// `APPLICATION_LOGS`.
    ///
    /// * For Elemental MediaPackage, the valid values are `EGRESS_ACCESS_LOGS` and
    /// `INGRESS_ACCESS_LOGS`.
    ///
    /// * For Elemental MediaTailor, the valid values are `AD_DECISION_SERVER_LOGS`,
    /// `MANIFEST_SERVICE_LOGS`, and `TRANSCODE_LOGS`.
    ///
    /// * For Entity Resolution, the valid value is `WORKFLOW_LOGS`.
    ///
    /// * For IAM Identity Center, the valid value is
    /// `ERROR_LOGS`.
    ///
    /// * For Network Firewall Proxy, the valid values are `ALERT_LOGS`,
    /// `ALLOW_LOGS`, and `DENY_LOGS`.
    ///
    /// * For Network Load Balancer, the valid value is `NLB_ACCESS_LOGS`.
    ///
    /// * For PCS, the valid values are `PCS_SCHEDULER_LOGS`,
    /// `PCS_JOBCOMP_LOGS`, and `PCS_SCHEDULER_AUDIT_LOGS`.
    ///
    /// * For Amazon Q, the valid values are `EVENT_LOGS` and
    /// `SYNC_JOB_LOGS`.
    ///
    /// * For Amazon Q in Connect AI agents, the valid value is
    /// `EVENT_LOGS`.
    ///
    /// * For Quick, the valid values are `AGENT_HOURS_LOGS`,
    /// `AGENT_METADATA_LOGS`, `CHAT_LOGS`, `DLP_LOGS`,
    /// `FEEDBACK_LOGS`, `INDEX_USAGE_LOGS`, and
    /// `KB_FILE_SYNC_LOGS`.
    ///
    /// * For Route 53 Global Resolver, the valid value is
    /// `GLOBAL_RESOLVER_LOGS`.
    ///
    /// * For Amazon Web Services RTB Fabric, the valid value is
    /// `APPLICATION_LOGS`.
    ///
    /// * For Amazon S3, the valid value is
    /// `S3_SERVER_ACCESS_LOGS`.
    ///
    /// * For Amazon Web Services Security Hub, the valid value is
    /// `SECURITY_FINDING_LOGS`.
    ///
    /// * For Amazon Web Services Security Hub CSPM, the valid value is
    /// `SECURITY_FINDING_LOGS`.
    ///
    /// * For Amazon SES mail manager, the valid values are
    /// `APPLICATION_LOGS` and `TRAFFIC_POLICY_DEBUG_LOGS`.
    ///
    /// * For Amazon Web Services Shield Advanced, the valid value is
    /// `FLOW_LOGS`.
    ///
    /// * For Amazon VPC Route Server, the valid value is
    /// `EVENT_LOGS`.
    ///
    /// * For Amazon WorkMail, the valid values are `ACCESS_CONTROL_LOGS`,
    /// `AUTHENTICATION_LOGS`, `WORKMAIL_AVAILABILITY_PROVIDER_LOGS`,
    /// `WORKMAIL_MAILBOX_ACCESS_LOGS`, and
    /// `WORKMAIL_PERSONAL_ACCESS_TOKEN_LOGS`.
    log_type: []const u8,

    /// A name for this delivery source. This name must be unique for all delivery
    /// sources in your
    /// account.
    name: []const u8,

    /// The ARN of the Amazon Web Services resource that is generating and sending
    /// logs. For
    /// example,
    /// `arn:aws:workmail:us-east-1:123456789012:organization/m-1234EXAMPLEabcd1234abcd1234abcd1234`
    ///
    /// For the `SECURITY_FINDING_LOGS` logType, use a wildcard ARN for the hub
    /// resource. For Amazon Web Services Security Hub CSPM, use
    /// `arn:aws:securityhub:us-east-1:111122223333:hub/*`
    /// and for Amazon Web Services Security Hub, use
    /// `arn:aws:securityhub:us-east-1:111122223333:hubv2/*`
    ///
    /// For the `INSIGHTS_QUERY_LOGS` log type, use a wildcard log group ARN, such
    /// as
    /// `arn:aws:logs:us-east-1:111122223333:log-group:*`. Amazon Web Services does
    /// not support a
    /// specific log group ARN for this log type.
    resource_arn: []const u8,

    /// An optional list of key-value pairs to associate with the resource.
    ///
    /// For more information about tagging, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .delivery_source_configuration = "deliverySourceConfiguration",
        .log_type = "logType",
        .name = "name",
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};

pub const PutDeliverySourceOutput = struct {
    /// A structure containing information about the delivery source that was just
    /// created or
    /// updated.
    delivery_source: ?DeliverySource = null,

    pub const json_field_names = .{
        .delivery_source = "deliverySource",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDeliverySourceInput, options: CallOptions) !PutDeliverySourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutDeliverySourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutDeliverySource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDeliverySourceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutDeliverySourceOutput, body, allocator);
}
