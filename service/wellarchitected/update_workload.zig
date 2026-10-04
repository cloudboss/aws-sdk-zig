const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkloadDiscoveryConfig = @import("workload_discovery_config.zig").WorkloadDiscoveryConfig;
const WorkloadEnvironment = @import("workload_environment.zig").WorkloadEnvironment;
const WorkloadImprovementStatus = @import("workload_improvement_status.zig").WorkloadImprovementStatus;
const WorkloadJiraConfigurationInput = @import("workload_jira_configuration_input.zig").WorkloadJiraConfigurationInput;
const Workload = @import("workload.zig").Workload;

pub const UpdateWorkloadInput = struct {
    account_ids: ?[]const []const u8 = null,

    /// List of AppRegistry application ARNs to associate to the workload.
    applications: ?[]const []const u8 = null,

    architectural_design: ?[]const u8 = null,

    aws_regions: ?[]const []const u8 = null,

    description: ?[]const u8 = null,

    /// Well-Architected discovery configuration settings to associate to the
    /// workload.
    discovery_config: ?WorkloadDiscoveryConfig = null,

    environment: ?WorkloadEnvironment = null,

    improvement_status: ?WorkloadImprovementStatus = null,

    industry: ?[]const u8 = null,

    industry_type: ?[]const u8 = null,

    /// Flag indicating whether the workload owner has acknowledged that the *Review
    /// owner* field is required.
    ///
    /// If a **Review owner** is not added to the workload within
    /// 60 days of acknowledgement, access to the workload is restricted until an
    /// owner is
    /// added.
    is_review_owner_update_acknowledged: ?bool = null,

    /// Configuration of the Jira integration.
    jira_configuration: ?WorkloadJiraConfigurationInput = null,

    non_aws_regions: ?[]const []const u8 = null,

    notes: ?[]const u8 = null,

    pillar_priorities: ?[]const []const u8 = null,

    review_owner: ?[]const u8 = null,

    workload_id: []const u8,

    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .applications = "Applications",
        .architectural_design = "ArchitecturalDesign",
        .aws_regions = "AwsRegions",
        .description = "Description",
        .discovery_config = "DiscoveryConfig",
        .environment = "Environment",
        .improvement_status = "ImprovementStatus",
        .industry = "Industry",
        .industry_type = "IndustryType",
        .is_review_owner_update_acknowledged = "IsReviewOwnerUpdateAcknowledged",
        .jira_configuration = "JiraConfiguration",
        .non_aws_regions = "NonAwsRegions",
        .notes = "Notes",
        .pillar_priorities = "PillarPriorities",
        .review_owner = "ReviewOwner",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};

pub const UpdateWorkloadOutput = struct {
    workload: ?Workload = null,

    pub const json_field_names = .{
        .workload = "Workload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkloadInput, options: CallOptions) !UpdateWorkloadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkloadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.discovery_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DiscoveryConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Environment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.improvement_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ImprovementStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.is_review_owner_update_acknowledged) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsReviewOwnerUpdateAcknowledged\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.jira_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JiraConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.review_owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReviewOwner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workload_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WorkloadName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkloadOutput {
    var result: UpdateWorkloadOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateWorkloadOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
