const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const GetPlatformApplicationAttributesInput = struct {
    /// `PlatformApplicationArn` for GetPlatformApplicationAttributesInput.
    platform_application_arn: []const u8,
};

pub const GetPlatformApplicationAttributesOutput = struct {
    /// Attributes include the following:
    ///
    /// * `AppleCertificateExpiryDate` – The expiry date of the SSL
    /// certificate used to configure certificate-based authentication.
    ///
    /// * `ApplePlatformTeamID` – The Apple developer account ID used to
    /// configure token-based authentication.
    ///
    /// * `ApplePlatformBundleID` – The app identifier used to configure
    /// token-based authentication.
    ///
    /// * `AuthenticationMethod` – Returns the credential type used when
    /// sending push notifications from application to APNS/APNS_Sandbox, or
    /// application
    /// to GCM.
    ///
    /// * APNS – Returns the token or certificate.
    ///
    /// * GCM – Returns the token or key.
    ///
    /// * `EventEndpointCreated` – Topic ARN to which EndpointCreated
    /// event notifications should be sent.
    ///
    /// * `EventEndpointDeleted` – Topic ARN to which EndpointDeleted
    /// event notifications should be sent.
    ///
    /// * `EventEndpointUpdated` – Topic ARN to which EndpointUpdate
    /// event notifications should be sent.
    ///
    /// * `EventDeliveryFailure` – Topic ARN to which DeliveryFailure
    /// event notifications should be sent upon Direct Publish delivery failure
    /// (permanent) to one of the application's endpoints.
    attributes: ?[]const aws.map.StringMapEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlatformApplicationAttributesInput, options: CallOptions) !GetPlatformApplicationAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlatformApplicationAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetPlatformApplicationAttributes&Version=2010-03-31");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlatformApplicationAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetPlatformApplicationAttributesResult")) break;
            },
            else => {},
        }
    }

    var result: GetPlatformApplicationAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Attributes")) {
                    result.attributes = try serde.deserializeMapStringToString(allocator, &reader, "entry");
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
