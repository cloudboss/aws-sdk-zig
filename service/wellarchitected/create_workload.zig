const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkloadDiscoveryConfig = @import("workload_discovery_config.zig").WorkloadDiscoveryConfig;
const WorkloadEnvironment = @import("workload_environment.zig").WorkloadEnvironment;
const WorkloadJiraConfigurationInput = @import("workload_jira_configuration_input.zig").WorkloadJiraConfigurationInput;

pub const CreateWorkloadInput = struct {
    account_ids: ?[]const []const u8 = null,

    /// List of AppRegistry application ARNs associated to the workload.
    applications: ?[]const []const u8 = null,

    architectural_design: ?[]const u8 = null,

    aws_regions: ?[]const []const u8 = null,

    client_request_token: []const u8,

    description: []const u8,

    /// Well-Architected discovery configuration settings associated to the
    /// workload.
    discovery_config: ?WorkloadDiscoveryConfig = null,

    environment: WorkloadEnvironment,

    industry: ?[]const u8 = null,

    industry_type: ?[]const u8 = null,

    /// Jira configuration settings when creating a workload.
    jira_configuration: ?WorkloadJiraConfigurationInput = null,

    lenses: []const []const u8,

    non_aws_regions: ?[]const []const u8 = null,

    notes: ?[]const u8 = null,

    pillar_priorities: ?[]const []const u8 = null,

    /// The list of profile ARNs associated with the workload.
    profile_arns: ?[]const []const u8 = null,

    review_owner: ?[]const u8 = null,

    /// The list of review template ARNs to associate with the workload.
    review_template_arns: ?[]const []const u8 = null,

    /// The tags to be associated with the workload.
    tags: ?[]const aws.map.StringMapEntry = null,

    workload_name: []const u8,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .applications = "Applications",
        .architectural_design = "ArchitecturalDesign",
        .aws_regions = "AwsRegions",
        .client_request_token = "ClientRequestToken",
        .description = "Description",
        .discovery_config = "DiscoveryConfig",
        .environment = "Environment",
        .industry = "Industry",
        .industry_type = "IndustryType",
        .jira_configuration = "JiraConfiguration",
        .lenses = "Lenses",
        .non_aws_regions = "NonAwsRegions",
        .notes = "Notes",
        .pillar_priorities = "PillarPriorities",
        .profile_arns = "ProfileArns",
        .review_owner = "ReviewOwner",
        .review_template_arns = "ReviewTemplateArns",
        .tags = "Tags",
        .workload_name = "WorkloadName",
    };
};

pub const CreateWorkloadOutput = struct {
    workload_arn: ?[]const u8 = null,

    workload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .workload_arn = "WorkloadArn",
        .workload_id = "WorkloadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkloadInput, options: CallOptions) !CreateWorkloadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkloadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/workloads";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.applications) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Applications\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.architectural_design) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ArchitecturalDesign\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.aws_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AwsRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (input.discovery_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DiscoveryConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Environment\":");
    try aws.json.writeValue(@TypeOf(input.environment), input.environment, allocator, &body_buf);
    has_prev = true;
    if (input.industry) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Industry\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.industry_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IndustryType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.jira_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JiraConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Lenses\":");
    try aws.json.writeValue(@TypeOf(input.lenses), input.lenses, allocator, &body_buf);
    has_prev = true;
    if (input.non_aws_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NonAwsRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Notes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pillar_priorities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PillarPriorities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.profile_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProfileArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.review_owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReviewOwner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.review_template_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReviewTemplateArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"WorkloadName\":");
    try aws.json.writeValue(@TypeOf(input.workload_name), input.workload_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkloadOutput {
    const result: CreateWorkloadOutput = try aws.json.parseJsonObject(
        CreateWorkloadOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
