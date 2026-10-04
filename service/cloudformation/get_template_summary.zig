const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallAs = @import("call_as.zig").CallAs;
const TemplateSummaryConfig = @import("template_summary_config.zig").TemplateSummaryConfig;
const Capability = @import("capability.zig").Capability;
const ParameterDeclaration = @import("parameter_declaration.zig").ParameterDeclaration;
const ResourceIdentifierSummary = @import("resource_identifier_summary.zig").ResourceIdentifierSummary;
const Warnings = @import("warnings.zig").Warnings;
const serde = @import("serde.zig");

pub const GetTemplateSummaryInput = struct {
    /// [Service-managed permissions] Specifies whether you are acting as an account
    /// administrator
    /// in the organization's management account or as a delegated administrator in
    /// a
    /// member account.
    ///
    /// By default, `SELF` is specified. Use `SELF` for StackSets with
    /// self-managed permissions.
    ///
    /// * If you are signed in to the management account, specify
    /// `SELF`.
    ///
    /// * If you are signed in to a delegated administrator account, specify
    /// `DELEGATED_ADMIN`.
    ///
    /// Your Amazon Web Services account must be registered as a delegated
    /// administrator in the management account. For more information, see [Register
    /// a
    /// delegated
    /// administrator](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-delegated-admin.html) in the *CloudFormation User Guide*.
    call_as: ?CallAs = null,

    /// The name or the stack ID that's associated with the stack, which aren't
    /// always
    /// interchangeable. For running stacks, you can specify either the stack's name
    /// or its unique
    /// stack ID. For deleted stack, you must specify the unique stack ID.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `StackName`, `StackSetName`, `TemplateBody`, or
    /// `TemplateURL`.
    stack_name: ?[]const u8 = null,

    /// The name or unique ID of the StackSet from which the stack was created.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `StackName`, `StackSetName`, `TemplateBody`, or
    /// `TemplateURL`.
    stack_set_name: ?[]const u8 = null,

    /// Structure that contains the template body with a minimum length of 1 byte
    /// and a maximum
    /// length of 51,200 bytes.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `StackName`, `StackSetName`, `TemplateBody`, or
    /// `TemplateURL`.
    template_body: ?[]const u8 = null,

    /// Specifies options for the `GetTemplateSummary` API action.
    template_summary_config: ?TemplateSummaryConfig = null,

    /// The URL of a file that contains the template body. The URL must point to a
    /// template (max
    /// size: 1 MB) that's located in an Amazon S3 bucket or a Systems Manager
    /// document. The location for
    /// an Amazon S3 bucket must start with `https://`.
    ///
    /// Conditional: You must specify only one of the following parameters:
    /// `StackName`, `StackSetName`, `TemplateBody`, or
    /// `TemplateURL`.
    template_url: ?[]const u8 = null,
};

pub const GetTemplateSummaryOutput = struct {
    /// The capabilities found within the template. If your template contains IAM
    /// resources, you
    /// must specify the `CAPABILITY_IAM` or `CAPABILITY_NAMED_IAM` value for
    /// this parameter when you use the CreateStack or UpdateStack
    /// actions with your template; otherwise, those actions return an
    /// `InsufficientCapabilities` error.
    ///
    /// For more information, see [Acknowledging IAM resources in CloudFormation
    /// templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html#using-iam-capabilities).
    capabilities: ?[]const Capability = null,

    /// The list of resources that generated the values in the `Capabilities`
    /// response
    /// element.
    capabilities_reason: ?[]const u8 = null,

    /// A list of the transforms that are declared in the template.
    declared_transforms: ?[]const []const u8 = null,

    /// The value that's defined in the `Description` property of the template.
    description: ?[]const u8 = null,

    /// The value that's defined for the `Metadata` property of the template.
    metadata: ?[]const u8 = null,

    /// A list of parameter declarations that describe various properties for each
    /// parameter.
    parameters: ?[]const ParameterDeclaration = null,

    /// A list of resource identifier summaries that describe the target resources
    /// of an import
    /// operation and the properties you can provide during the import to identify
    /// the target
    /// resources. For example, `BucketName` is a possible identifier property for
    /// an
    /// `AWS::S3::Bucket` resource.
    resource_identifier_summaries: ?[]const ResourceIdentifierSummary = null,

    /// A list of all the template resource types that are defined in the template,
    /// such as
    /// `AWS::EC2::Instance`, `AWS::Dynamo::Table`, and
    /// `Custom::MyCustomInstance`.
    resource_types: ?[]const []const u8 = null,

    /// The Amazon Web Services template format version, which identifies the
    /// capabilities of the
    /// template.
    version: ?[]const u8 = null,

    /// An object that contains any warnings returned.
    warnings: ?Warnings = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateSummaryInput, options: CallOptions) !GetTemplateSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTemplateSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetTemplateSummary&Version=2010-05-15");
    if (input.call_as) |v| {
        try body_buf.appendSlice(allocator, "&CallAs=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.stack_name) |v| {
        try body_buf.appendSlice(allocator, "&StackName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.stack_set_name) |v| {
        try body_buf.appendSlice(allocator, "&StackSetName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.template_body) |v| {
        try body_buf.appendSlice(allocator, "&TemplateBody=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.template_summary_config) |v| {
        if (v.treat_unrecognized_resource_types_as_warnings) |sv| {
            try body_buf.appendSlice(allocator, "&TemplateSummaryConfig.TreatUnrecognizedResourceTypesAsWarnings=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.template_url) |v| {
        try body_buf.appendSlice(allocator, "&TemplateURL=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTemplateSummaryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetTemplateSummaryResult")) break;
            },
            else => {},
        }
    }

    var result: GetTemplateSummaryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Capabilities")) {
                    result.capabilities = try serde.deserializeCapabilities(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "CapabilitiesReason")) {
                    result.capabilities_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeclaredTransforms")) {
                    result.declared_transforms = try serde.deserializeTransformsList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metadata")) {
                    result.metadata = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try serde.deserializeParameterDeclarations(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifierSummaries")) {
                    result.resource_identifier_summaries = try serde.deserializeResourceIdentifierSummaries(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceTypes")) {
                    result.resource_types = try serde.deserializeResourceTypes(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    result.version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Warnings")) {
                    result.warnings = try serde.deserializeWarnings(allocator, &reader);
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
