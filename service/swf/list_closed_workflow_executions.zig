const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloseStatusFilter = @import("close_status_filter.zig").CloseStatusFilter;
const ExecutionTimeFilter = @import("execution_time_filter.zig").ExecutionTimeFilter;
const WorkflowExecutionFilter = @import("workflow_execution_filter.zig").WorkflowExecutionFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;
const WorkflowTypeFilter = @import("workflow_type_filter.zig").WorkflowTypeFilter;
const WorkflowExecutionInfo = @import("workflow_execution_info.zig").WorkflowExecutionInfo;

pub const ListClosedWorkflowExecutionsInput = struct {
    /// If specified, only workflow executions that match this *close
    /// status* are listed. For example, if TERMINATED is specified, then only
    /// TERMINATED
    /// workflow executions are listed.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    close_status_filter: ?CloseStatusFilter = null,

    /// If specified, the workflow executions are included in the returned results
    /// based on
    /// whether their close times are within the range specified by this filter.
    /// Also, if this
    /// parameter is specified, the returned results are ordered by their close
    /// times.
    ///
    /// `startTimeFilter` and `closeTimeFilter` are mutually exclusive. You
    /// must specify one of these in a request but not both.
    close_time_filter: ?ExecutionTimeFilter = null,

    /// The name of the domain that contains the workflow executions to list.
    domain: []const u8,

    /// If specified, only workflow executions matching the workflow ID specified in
    /// the filter
    /// are returned.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    execution_filter: ?WorkflowExecutionFilter = null,

    /// The maximum number of results that are returned per call.
    /// Use `nextPageToken` to obtain further pages of results.
    maximum_page_size: ?i32 = null,

    /// If `NextPageToken` is returned there are more results
    /// available. The value of `NextPageToken` is a unique pagination token for
    /// each page. Make the call again using
    /// the returned token to retrieve the next page. Keep all other arguments
    /// unchanged. Each pagination token expires
    /// after 24 hours. Using an expired pagination token will return a `400` error:
    /// "`Specified token has
    /// exceeded its maximum lifetime`".
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    /// When set to `true`, returns the results in reverse order. By default the
    /// results are returned in descending order of the start or the close time of
    /// the
    /// executions.
    reverse_order: ?bool = null,

    /// If specified, the workflow executions are included in the returned results
    /// based on
    /// whether their start times are within the range specified by this filter.
    /// Also, if this
    /// parameter is specified, the returned results are ordered by their start
    /// times.
    ///
    /// `startTimeFilter` and `closeTimeFilter` are mutually exclusive. You
    /// must specify one of these in a request but not both.
    start_time_filter: ?ExecutionTimeFilter = null,

    /// If specified, only executions that have the matching tag are listed.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    tag_filter: ?TagFilter = null,

    /// If specified, only executions of the type specified in the filter are
    /// returned.
    ///
    /// `closeStatusFilter`, `executionFilter`, `typeFilter` and
    /// `tagFilter` are mutually exclusive. You can specify at most one of these in
    /// a
    /// request.
    type_filter: ?WorkflowTypeFilter = null,

    pub const json_field_names = .{
        .close_status_filter = "closeStatusFilter",
        .close_time_filter = "closeTimeFilter",
        .domain = "domain",
        .execution_filter = "executionFilter",
        .maximum_page_size = "maximumPageSize",
        .next_page_token = "nextPageToken",
        .reverse_order = "reverseOrder",
        .start_time_filter = "startTimeFilter",
        .tag_filter = "tagFilter",
        .type_filter = "typeFilter",
    };
};

pub const ListClosedWorkflowExecutionsOutput = struct {
    /// The list of workflow information structures.
    execution_infos: ?[]const WorkflowExecutionInfo = null,

    /// If a `NextPageToken` was returned by a previous call, there are more
    /// results available. To retrieve the next page of results, make the call again
    /// using the returned token in
    /// `nextPageToken`. Keep all other arguments unchanged.
    ///
    /// The configured `maximumPageSize` determines how many results can be returned
    /// in a single call.
    next_page_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_infos = "executionInfos",
        .next_page_token = "nextPageToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClosedWorkflowExecutionsInput, options: CallOptions) !ListClosedWorkflowExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClosedWorkflowExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.ListClosedWorkflowExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClosedWorkflowExecutionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListClosedWorkflowExecutionsOutput, body, allocator);
}
