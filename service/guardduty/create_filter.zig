const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FilterAction = @import("filter_action.zig").FilterAction;
const FindingCriteria = @import("finding_criteria.zig").FindingCriteria;

pub const CreateFilterInput = struct {
    /// Specifies the action that is to be applied to the findings that match the
    /// filter.
    action: ?FilterAction = null,

    /// The idempotency token for the create request.
    client_token: ?[]const u8 = null,

    /// The description of the filter. Valid characters include alphanumeric
    /// characters, and
    /// special characters such as hyphen, period, colon, underscore, parentheses
    /// (`{ }`,
    /// `[ ]`, and `( )`), forward slash, horizontal tab, vertical tab,
    /// newline, form feed, return, and whitespace.
    description: ?[]const u8 = null,

    /// The detector ID associated with the GuardDuty account for which you want to
    /// create a filter.
    ///
    /// To find the `detectorId` in the current Region, see the
    /// Settings page in the GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// Represents the criteria to be used in the filter for querying findings.
    ///
    /// You can only use the following attributes to query findings:
    ///
    /// * accountId
    ///
    /// * id
    ///
    /// * region
    ///
    /// * severity
    ///
    /// To filter on the basis of severity, the API and CLI use the following input
    /// list for
    /// the
    /// [FindingCriteria](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_FindingCriteria.html)
    /// condition:
    ///
    /// * **Low**: `["1", "2", "3"]`
    ///
    /// * **Medium**: `["4", "5", "6"]`
    ///
    /// * **High**: `["7", "8"]`
    ///
    /// * **Critical**: `["9", "10"]`
    ///
    /// For more information, see [Findings severity
    /// levels](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_findings-severity.html)
    /// in the *Amazon GuardDuty User Guide*.
    ///
    /// * type
    ///
    /// * updatedAt
    ///
    /// Type: ISO 8601 string format: YYYY-MM-DDTHH:MM:SS.SSSZ or
    /// YYYY-MM-DDTHH:MM:SSZ
    /// depending on whether the value contains milliseconds.
    ///
    /// * resource.accessKeyDetails.accessKeyId
    ///
    /// * resource.accessKeyDetails.principalId
    ///
    /// * resource.accessKeyDetails.userName
    ///
    /// * resource.accessKeyDetails.userType
    ///
    /// * resource.instanceDetails.iamInstanceProfile.id
    ///
    /// * resource.instanceDetails.imageId
    ///
    /// * resource.instanceDetails.instanceId
    ///
    /// * resource.instanceDetails.tags.key
    ///
    /// * resource.instanceDetails.tags.value
    ///
    /// * resource.instanceDetails.networkInterfaces.ipv6Addresses
    ///
    /// *
    ///   resource.instanceDetails.networkInterfaces.privateIpAddresses.privateIpAddress
    ///
    /// * resource.instanceDetails.networkInterfaces.publicDnsName
    ///
    /// * resource.instanceDetails.networkInterfaces.publicIp
    ///
    /// * resource.instanceDetails.networkInterfaces.securityGroups.groupId
    ///
    /// * resource.instanceDetails.networkInterfaces.securityGroups.groupName
    ///
    /// * resource.instanceDetails.networkInterfaces.subnetId
    ///
    /// * resource.instanceDetails.networkInterfaces.vpcId
    ///
    /// * resource.instanceDetails.outpostArn
    ///
    /// * resource.resourceType
    ///
    /// * resource.s3BucketDetails.publicAccess.effectivePermissions
    ///
    /// * resource.s3BucketDetails.name
    ///
    /// * resource.s3BucketDetails.tags.key
    ///
    /// * resource.s3BucketDetails.tags.value
    ///
    /// * resource.s3BucketDetails.type
    ///
    /// * service.action.actionType
    ///
    /// * service.action.awsApiCallAction.api
    ///
    /// * service.action.awsApiCallAction.callerType
    ///
    /// * service.action.awsApiCallAction.errorCode
    ///
    /// * service.action.awsApiCallAction.remoteIpDetails.city.cityName
    ///
    /// * service.action.awsApiCallAction.remoteIpDetails.country.countryName
    ///
    /// * service.action.awsApiCallAction.remoteIpDetails.ipAddressV4
    ///
    /// * service.action.awsApiCallAction.remoteIpDetails.ipAddressV6
    ///
    /// * service.action.awsApiCallAction.remoteIpDetails.organization.asn
    ///
    /// * service.action.awsApiCallAction.remoteIpDetails.organization.asnOrg
    ///
    /// * service.action.awsApiCallAction.serviceName
    ///
    /// * service.action.dnsRequestAction.domain
    ///
    /// * service.action.dnsRequestAction.domainWithSuffix
    ///
    /// * service.action.dnsRequestAction.vpcOwnerAccountId
    ///
    /// * service.action.networkConnectionAction.blocked
    ///
    /// * service.action.networkConnectionAction.connectionDirection
    ///
    /// * service.action.networkConnectionAction.localPortDetails.port
    ///
    /// * service.action.networkConnectionAction.protocol
    ///
    /// * service.action.networkConnectionAction.remoteIpDetails.city.cityName
    ///
    /// * service.action.networkConnectionAction.remoteIpDetails.country.countryName
    ///
    /// * service.action.networkConnectionAction.remoteIpDetails.ipAddressV4
    ///
    /// * service.action.networkConnectionAction.remoteIpDetails.ipAddressV6
    ///
    /// * service.action.networkConnectionAction.remoteIpDetails.organization.asn
    ///
    /// * service.action.networkConnectionAction.remoteIpDetails.organization.asnOrg
    ///
    /// * service.action.networkConnectionAction.remotePortDetails.port
    ///
    /// * service.action.awsApiCallAction.remoteAccountDetails.affiliated
    ///
    /// * service.action.kubernetesApiCallAction.remoteIpDetails.ipAddressV4
    ///
    /// * service.action.kubernetesApiCallAction.remoteIpDetails.ipAddressV6
    ///
    /// * service.action.kubernetesApiCallAction.namespace
    ///
    /// * service.action.kubernetesApiCallAction.remoteIpDetails.organization.asn
    ///
    /// * service.action.kubernetesApiCallAction.requestUri
    ///
    /// * service.action.kubernetesApiCallAction.statusCode
    ///
    /// * service.action.networkConnectionAction.localIpDetails.ipAddressV4
    ///
    /// * service.action.networkConnectionAction.localIpDetails.ipAddressV6
    ///
    /// * service.action.networkConnectionAction.protocol
    ///
    /// * service.action.awsApiCallAction.serviceName
    ///
    /// * service.action.awsApiCallAction.remoteAccountDetails.accountId
    ///
    /// * service.additionalInfo.threatListName
    ///
    /// * service.resourceRole
    ///
    /// * resource.eksClusterDetails.name
    ///
    /// * resource.kubernetesDetails.kubernetesWorkloadDetails.name
    ///
    /// * resource.kubernetesDetails.kubernetesWorkloadDetails.namespace
    ///
    /// * resource.kubernetesDetails.kubernetesUserDetails.username
    ///
    /// * resource.kubernetesDetails.kubernetesWorkloadDetails.containers.image
    ///
    /// *
    ///   resource.kubernetesDetails.kubernetesWorkloadDetails.containers.imagePrefix
    ///
    /// * service.ebsVolumeScanDetails.scanId
    ///
    /// *
    ///   service.ebsVolumeScanDetails.scanDetections.threatDetectedByName.threatNames.name
    ///
    /// *
    ///   service.ebsVolumeScanDetails.scanDetections.threatDetectedByName.threatNames.severity
    ///
    /// *
    ///   service.ebsVolumeScanDetails.scanDetections.threatDetectedByName.threatNames.filePaths.hash
    ///
    /// * resource.ecsClusterDetails.name
    ///
    /// * resource.ecsClusterDetails.taskDetails.containers.image
    ///
    /// * resource.ecsClusterDetails.taskDetails.definitionArn
    ///
    /// * resource.containerDetails.image
    ///
    /// * resource.rdsDbInstanceDetails.dbInstanceIdentifier
    ///
    /// * resource.rdsDbInstanceDetails.dbClusterIdentifier
    ///
    /// * resource.rdsDbInstanceDetails.engine
    ///
    /// * resource.rdsDbUserDetails.user
    ///
    /// * resource.rdsDbInstanceDetails.tags.key
    ///
    /// * resource.rdsDbInstanceDetails.tags.value
    ///
    /// * service.runtimeDetails.process.executableSha256
    ///
    /// * service.runtimeDetails.process.name
    ///
    /// * service.runtimeDetails.process.executablePath
    ///
    /// * resource.lambdaDetails.functionName
    ///
    /// * resource.lambdaDetails.functionArn
    ///
    /// * resource.lambdaDetails.tags.key
    ///
    /// * resource.lambdaDetails.tags.value
    finding_criteria: FindingCriteria,

    /// The name of the filter. Valid characters include period (.), underscore (_),
    /// dash (-), and
    /// alphanumeric characters. A whitespace is considered to be an invalid
    /// character.
    name: []const u8,

    /// Specifies the position of the filter in the list of current filters. Also
    /// specifies the
    /// order in which this filter is applied to the findings.
    rank: ?i32 = null,

    /// The tags to be added to a new filter resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "Action",
        .client_token = "ClientToken",
        .description = "Description",
        .detector_id = "DetectorId",
        .finding_criteria = "FindingCriteria",
        .name = "Name",
        .rank = "Rank",
        .tags = "Tags",
    };
};

pub const CreateFilterOutput = struct {
    /// The name of the successfully created filter.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFilterInput, options: CallOptions) !CreateFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "guardduty");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/filter");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Action\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FindingCriteria\":");
    try aws.json.writeValue(@TypeOf(input.finding_criteria), input.finding_criteria, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.rank) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Rank\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFilterOutput {
    var result: CreateFilterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFilterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
