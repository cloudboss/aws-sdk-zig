const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingCriteria = @import("finding_criteria.zig").FindingCriteria;
const SortCriteria = @import("sort_criteria.zig").SortCriteria;

pub const ListFindingsInput = struct {
    /// The ID of the detector that specifies the GuardDuty service whose findings
    /// you want to list.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// Represents the criteria used for querying findings. Valid values include:
    ///
    /// * JSON field name
    /// * accountId
    /// * region
    /// * confidence
    /// * id
    /// * resource.accessKeyDetails.accessKeyId
    /// * resource.accessKeyDetails.principalId
    /// * resource.accessKeyDetails.userName
    /// * resource.accessKeyDetails.userType
    /// * resource.instanceDetails.iamInstanceProfile.id
    /// * resource.instanceDetails.imageId
    /// * resource.instanceDetails.instanceId
    /// * resource.instanceDetails.networkInterfaces.ipv6Addresses
    /// *
    ///   resource.instanceDetails.networkInterfaces.privateIpAddresses.privateIpAddress
    /// * resource.instanceDetails.networkInterfaces.publicDnsName
    /// * resource.instanceDetails.networkInterfaces.publicIp
    /// * resource.instanceDetails.networkInterfaces.securityGroups.groupId
    /// * resource.instanceDetails.networkInterfaces.securityGroups.groupName
    /// * resource.instanceDetails.networkInterfaces.subnetId
    /// * resource.instanceDetails.networkInterfaces.vpcId
    /// * resource.instanceDetails.tags.key
    /// * resource.instanceDetails.tags.value
    /// * resource.resourceType
    /// * service.action.actionType
    /// * service.action.awsApiCallAction.api
    /// * service.action.awsApiCallAction.callerType
    /// * service.action.awsApiCallAction.remoteIpDetails.city.cityName
    /// * service.action.awsApiCallAction.remoteIpDetails.country.countryName
    /// * service.action.awsApiCallAction.remoteIpDetails.ipAddressV4
    /// * service.action.awsApiCallAction.remoteIpDetails.organization.asn
    /// * service.action.awsApiCallAction.remoteIpDetails.organization.asnOrg
    /// * service.action.awsApiCallAction.serviceName
    /// * service.action.dnsRequestAction.domain
    /// * service.action.dnsRequestAction.domainWithSuffix
    /// * service.action.networkConnectionAction.blocked
    /// * service.action.networkConnectionAction.connectionDirection
    /// * service.action.networkConnectionAction.localPortDetails.port
    /// * service.action.networkConnectionAction.protocol
    /// * service.action.networkConnectionAction.remoteIpDetails.country.countryName
    /// * service.action.networkConnectionAction.remoteIpDetails.ipAddressV4
    /// * service.action.networkConnectionAction.remoteIpDetails.organization.asn
    /// * service.action.networkConnectionAction.remoteIpDetails.organization.asnOrg
    /// * service.action.networkConnectionAction.remotePortDetails.port
    /// * service.additionalInfo.threatListName
    /// * service.archived
    ///
    /// When this attribute is set to 'true', only archived findings are listed.
    /// When it's set to 'false', only unarchived findings are listed. When this
    /// attribute is not set, all existing findings are listed.
    /// * service.ebsVolumeScanDetails.scanId
    /// * service.resourceRole
    /// * severity
    /// * type
    /// * updatedAt
    ///
    /// Type: Timestamp in Unix Epoch millisecond format: 1486685375000
    finding_criteria: ?FindingCriteria = null,

    /// You can use this parameter to indicate the maximum number of items you want
    /// in the response. The default value is 50. The maximum value is 50.
    max_results: ?i32 = null,

    /// You can use this parameter when paginating results. Set the value of this
    /// parameter to null on your first call to the list action. For subsequent
    /// calls to the action, fill nextToken in the request with the value of
    /// NextToken from the previous response to continue listing data.
    next_token: ?[]const u8 = null,

    /// Represents the criteria used for sorting findings.
    sort_criteria: ?SortCriteria = null,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .finding_criteria = "FindingCriteria",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_criteria = "SortCriteria",
    };
};

pub const ListFindingsOutput = struct {
    /// The IDs of the findings that you're listing.
    finding_ids: ?[]const []const u8 = null,

    /// The pagination parameter to be used on the next list operation to retrieve
    /// more items.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .finding_ids = "FindingIds",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingsInput, options: CallOptions) !ListFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/findings");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.finding_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FindingCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingsOutput {
    const result: ListFindingsOutput = try aws.json.parseJsonObject(
        ListFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
