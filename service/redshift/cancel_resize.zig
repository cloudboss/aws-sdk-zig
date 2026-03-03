const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const serde = @import("serde.zig");

pub const CancelResizeInput = struct {
    /// The unique identifier for the cluster that you want to cancel a resize
    /// operation
    /// for.
    cluster_identifier: []const u8,
};

pub const CancelResizeOutput = struct {
    /// The average rate of the resize operation over the last few minutes, measured
    /// in
    /// megabytes per second. After the resize operation completes, this value shows
    /// the average
    /// rate of the entire resize operation.
    avg_resize_rate_in_mega_bytes_per_second: ?f64 = null,

    /// The percent of data transferred from source cluster to target cluster.
    data_transfer_progress_percent: ?f64 = null,

    /// The amount of seconds that have elapsed since the resize operation began.
    /// After the
    /// resize operation completes, this value shows the total actual time, in
    /// seconds, for the
    /// resize operation.
    elapsed_time_in_seconds: ?i64 = null,

    /// The estimated time remaining, in seconds, until the resize operation is
    /// complete.
    /// This value is calculated based on the average resize rate and the estimated
    /// amount of
    /// data remaining to be processed. Once the resize operation is complete, this
    /// value will
    /// be 0.
    estimated_time_to_completion_in_seconds: ?i64 = null,

    /// The names of tables that have been completely imported .
    ///
    /// Valid Values: List of table names.
    import_tables_completed: ?[]const []const u8 = null,

    /// The names of tables that are being currently imported.
    ///
    /// Valid Values: List of table names.
    import_tables_in_progress: ?[]const []const u8 = null,

    /// The names of tables that have not been yet imported.
    ///
    /// Valid Values: List of table names
    import_tables_not_started: ?[]const []const u8 = null,

    /// An optional string to provide additional details about the resize action.
    message: ?[]const u8 = null,

    /// While the resize operation is in progress, this value shows the current
    /// amount of
    /// data, in megabytes, that has been processed so far. When the resize
    /// operation is
    /// complete, this value shows the total amount of data, in megabytes, on the
    /// cluster, which
    /// may be more or less than TotalResizeDataInMegaBytes (the estimated total
    /// amount of data
    /// before resize).
    progress_in_mega_bytes: ?i64 = null,

    /// An enum with possible values of `ClassicResize` and
    /// `ElasticResize`. These values describe the type of resize operation being
    /// performed.
    resize_type: ?[]const u8 = null,

    /// The status of the resize operation.
    ///
    /// Valid Values: `NONE` | `IN_PROGRESS` | `FAILED` |
    /// `SUCCEEDED` | `CANCELLING`
    status: ?[]const u8 = null,

    /// The cluster type after the resize operation is complete.
    ///
    /// Valid Values: `multi-node` | `single-node`
    target_cluster_type: ?[]const u8 = null,

    /// The type of encryption for the cluster after the resize is complete.
    ///
    /// Possible values are `KMS` and `None`.
    target_encryption_type: ?[]const u8 = null,

    /// The node type that the cluster will have after the resize operation is
    /// complete.
    target_node_type: ?[]const u8 = null,

    /// The number of nodes that the cluster will have after the resize operation is
    /// complete.
    target_number_of_nodes: ?i32 = null,

    /// The estimated total amount of data, in megabytes, on the cluster before the
    /// resize
    /// operation began.
    total_resize_data_in_mega_bytes: ?i64 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelResizeInput, options: Options) !CancelResizeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "redshift");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelResizeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CancelResize&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelResizeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CancelResizeResult")) break;
            },
            else => {},
        }
    }

    var result: CancelResizeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvgResizeRateInMegaBytesPerSecond")) {
                    result.avg_resize_rate_in_mega_bytes_per_second = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DataTransferProgressPercent")) {
                    result.data_transfer_progress_percent = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ElapsedTimeInSeconds")) {
                    result.elapsed_time_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EstimatedTimeToCompletionInSeconds")) {
                    result.estimated_time_to_completion_in_seconds = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ImportTablesCompleted")) {
                    result.import_tables_completed = try serde.deserializeImportTablesCompleted(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ImportTablesInProgress")) {
                    result.import_tables_in_progress = try serde.deserializeImportTablesInProgress(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ImportTablesNotStarted")) {
                    result.import_tables_not_started = try serde.deserializeImportTablesNotStarted(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ProgressInMegaBytes")) {
                    result.progress_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResizeType")) {
                    result.resize_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetClusterType")) {
                    result.target_cluster_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetEncryptionType")) {
                    result.target_encryption_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetNodeType")) {
                    result.target_node_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetNumberOfNodes")) {
                    result.target_number_of_nodes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalResizeDataInMegaBytes")) {
                    result.total_resize_data_in_mega_bytes = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccessToClusterDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_to_cluster_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessToSnapshotDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_to_snapshot_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationProfileAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authentication_profile_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationProfileNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authentication_profile_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationProfileQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .authentication_profile_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .authorization_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchDeleteRequestSizeExceededFault")) {
        return .{ .arena = arena, .kind = .{ .batch_delete_request_size_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BatchModifyClusterSnapshotsLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .batch_modify_cluster_snapshots_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .bucket_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterOnLatestRevisionFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_on_latest_revision_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterParameterGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_parameter_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterParameterGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_parameter_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterParameterGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_parameter_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSecurityGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_security_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSecurityGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_security_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSecurityGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_security_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSnapshotAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_snapshot_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSnapshotNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_snapshot_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSnapshotQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_snapshot_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetGroupAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_group_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetGroupNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_group_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetGroupQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_group_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterSubnetQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .cluster_subnet_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictPolicyUpdateFault")) {
        return .{ .arena = arena, .kind = .{ .conflict_policy_update_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CopyToRegionDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .copy_to_region_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomCnameAssociationFault")) {
        return .{ .arena = arena, .kind = .{ .custom_cname_association_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CustomDomainAssociationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .custom_domain_association_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceAccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceRequestThrottlingFault")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_request_throttling_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependentServiceUnavailableFault")) {
        return .{ .arena = arena, .kind = .{ .dependent_service_unavailable_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAuthorizationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_authorization_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAuthorizationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_authorization_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointAuthorizationsPerClusterLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_authorizations_per_cluster_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .endpoint_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointsPerAuthorizationLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .endpoints_per_authorization_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EndpointsPerClusterLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .endpoints_per_cluster_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventSubscriptionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .event_subscription_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmClientCertificateAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_client_certificate_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmClientCertificateNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_client_certificate_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmClientCertificateQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_client_certificate_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmConfigurationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_configuration_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmConfigurationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_configuration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HsmConfigurationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .hsm_configuration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InProgressTableRestoreQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .in_progress_table_restore_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleOrderableOptions")) {
        return .{ .arena = arena, .kind = .{ .incompatible_orderable_options = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientClusterCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_cluster_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientS3BucketPolicyFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_s3_bucket_policy_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .integration_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictStateFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationSourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_source_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationTargetNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_target_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthenticationProfileRequestFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_authentication_profile_request_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthorizationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_authorization_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterParameterGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_parameter_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSecurityGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_security_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSnapshotScheduleStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_snapshot_schedule_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSnapshotStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_snapshot_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSubnetGroupStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_subnet_group_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterSubnetStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_subnet_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterTrackFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_cluster_track_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDataShareFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_share_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidElasticIpFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_elastic_ip_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndpointStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_endpoint_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHsmClientCertificateStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_hsm_client_certificate_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHsmConfigurationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_hsm_configuration_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNamespaceFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_namespace_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidReservedNodeStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_reserved_node_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRestoreFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_restore_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRetentionPeriodFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_retention_period_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketNameFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_name_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyPrefixFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_key_prefix_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidScheduleFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_schedule_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidScheduledActionFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_scheduled_action_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnapshotCopyGrantStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_snapshot_copy_grant_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubscriptionStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_subscription_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTableRestoreArgumentFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_table_restore_argument_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUsageLimitFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_usage_limit_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ipv6CidrBlockNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .ipv_6_cidr_block_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NumberOfNodesPerClusterLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .number_of_nodes_per_cluster_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NumberOfNodesQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .number_of_nodes_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PartnerNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .partner_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftIdcApplicationAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_idc_application_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftIdcApplicationNotExistsFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_idc_application_not_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftIdcApplicationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_idc_application_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RedshiftInvalidParameterFault")) {
        return .{ .arena = arena, .kind = .{ .redshift_invalid_parameter_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeAlreadyMigratedFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_already_migrated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeExchangeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_exchange_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeOfferingNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_offering_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .reserved_node_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResizeNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resize_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduleDefinitionTypeUnsupportedFault")) {
        return .{ .arena = arena, .kind = .{ .schedule_definition_type_unsupported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ScheduledActionTypeUnsupportedFault")) {
        return .{ .arena = arena, .kind = .{ .scheduled_action_type_unsupported_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyAlreadyDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_already_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyAlreadyEnabledFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_already_enabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyGrantAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_grant_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyGrantNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_grant_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotCopyGrantQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_copy_grant_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotScheduleUpdateInProgressFault")) {
        return .{ .arena = arena, .kind = .{ .snapshot_schedule_update_in_progress_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSTopicArnNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .sns_topic_arn_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .source_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionAlreadyExistFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_already_exist_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionCategoryNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_category_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionEventIdNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_event_id_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubscriptionSeverityNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .subscription_severity_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .table_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TableRestoreNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .table_restore_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedOperation")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_operation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedPartnerIntegrationFault")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_partner_integration_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownSnapshotCopyRegionFault")) {
        return .{ .arena = arena, .kind = .{ .unknown_snapshot_copy_region_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationFault")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOptionFault")) {
        return .{ .arena = arena, .kind = .{ .unsupported_option_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UsageLimitAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .usage_limit_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UsageLimitNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .usage_limit_not_found_fault = .{
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
