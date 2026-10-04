const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const SetPlatformApplicationAttributesInput = struct {
    /// A map of the platform application attributes. Attributes in this map include
    /// the
    /// following:
    ///
    /// * `PlatformCredential` – The credential received from the
    /// notification service.
    ///
    /// * For ADM, `PlatformCredential`is client secret.
    ///
    /// * For Apple Services using certificate credentials,
    /// `PlatformCredential` is private key.
    ///
    /// * For Apple Services using token credentials,
    /// `PlatformCredential` is signing key.
    ///
    /// * For GCM (Firebase Cloud Messaging) using key credentials, there is no
    /// `PlatformPrincipal`. The `PlatformCredential`
    /// is `API key`.
    ///
    /// * For GCM (Firebase Cloud Messaging) using token credentials, there is
    /// no `PlatformPrincipal`. The `PlatformCredential`
    /// is a JSON formatted private key file. When using the Amazon Web Services
    /// CLI, the file
    /// must be in string format and special characters must be ignored. To
    /// format the file correctly, Amazon SNS recommends using the following
    /// command:
    /// `SERVICE_JSON=`jq @json <<< cat
    /// service.json``.
    ///
    /// * `PlatformPrincipal` – The principal received from the
    /// notification service.
    ///
    /// * For ADM, `PlatformPrincipal`is client id.
    ///
    /// * For Apple Services using certificate credentials,
    /// `PlatformPrincipal` is SSL certificate.
    ///
    /// * For Apple Services using token credentials,
    /// `PlatformPrincipal` is signing key ID.
    ///
    /// * For GCM (Firebase Cloud Messaging), there is no
    /// `PlatformPrincipal`.
    ///
    /// * `EventEndpointCreated` – Topic ARN to which
    /// `EndpointCreated` event notifications are sent.
    ///
    /// * `EventEndpointDeleted` – Topic ARN to which
    /// `EndpointDeleted` event notifications are sent.
    ///
    /// * `EventEndpointUpdated` – Topic ARN to which
    /// `EndpointUpdate` event notifications are sent.
    ///
    /// * `EventDeliveryFailure` – Topic ARN to which
    /// `DeliveryFailure` event notifications are sent upon Direct
    /// Publish delivery failure (permanent) to one of the application's
    /// endpoints.
    ///
    /// * `SuccessFeedbackRoleArn` – IAM role ARN used to give Amazon SNS
    /// write access to use CloudWatch Logs on your behalf.
    ///
    /// * `FailureFeedbackRoleArn` – IAM role ARN used to give Amazon SNS
    /// write access to use CloudWatch Logs on your behalf.
    ///
    /// * `SuccessFeedbackSampleRate` – Sample rate percentage (0-100)
    /// of successfully delivered messages.
    ///
    /// The following attributes only apply to `APNs` token-based
    /// authentication:
    ///
    /// * `ApplePlatformTeamID` – The identifier that's assigned to your
    /// Apple developer account team.
    ///
    /// * `ApplePlatformBundleID` – The bundle identifier that's assigned to
    /// your iOS app.
    attributes: []const aws.map.StringMapEntry,

    /// `PlatformApplicationArn` for `SetPlatformApplicationAttributes`
    /// action.
    platform_application_arn: []const u8,
};

pub const SetPlatformApplicationAttributesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetPlatformApplicationAttributesInput, options: CallOptions) !SetPlatformApplicationAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetPlatformApplicationAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetPlatformApplicationAttributes&Version=2010-03-31");
    for (input.attributes, 0..) |entry, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            const key_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.key=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, key_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, entry.key);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const val_prefix = std.fmt.bufPrint(&prefix_buf, "&Attributes.entry.{d}.value=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, val_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, entry.value);
        }
    }
    try body_buf.appendSlice(allocator, "&PlatformApplicationArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.platform_application_arn);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetPlatformApplicationAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetPlatformApplicationAttributesOutput = .{};

    return result;
}
