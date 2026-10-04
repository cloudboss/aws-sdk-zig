const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RCTAppliedFor = @import("rct_applied_for.zig").RCTAppliedFor;
const EncryptionConfigurationForRepositoryCreationTemplate = @import("encryption_configuration_for_repository_creation_template.zig").EncryptionConfigurationForRepositoryCreationTemplate;
const ImageTagMutability = @import("image_tag_mutability.zig").ImageTagMutability;
const ImageTagMutabilityExclusionFilter = @import("image_tag_mutability_exclusion_filter.zig").ImageTagMutabilityExclusionFilter;
const Tag = @import("tag.zig").Tag;
const RepositoryCreationTemplate = @import("repository_creation_template.zig").RepositoryCreationTemplate;

pub const UpdateRepositoryCreationTemplateInput = struct {
    /// Updates the list of enumerable strings representing the Amazon ECR
    /// repository creation
    /// scenarios that this template will apply towards. The supported scenarios are
    /// `PULL_THROUGH_CACHE`, `REPLICATION`, and `CREATE_ON_PUSH`
    applied_for: ?[]const RCTAppliedFor = null,

    /// The ARN of the role to be assumed by Amazon ECR. This role must be in the
    /// same account as
    /// the registry that you are configuring. Amazon ECR will assume your supplied
    /// role when the
    /// customRoleArn is specified. When this field isn't specified, Amazon ECR will
    /// use the
    /// service-linked role for the repository creation template.
    custom_role_arn: ?[]const u8 = null,

    /// A description for the repository creation template.
    description: ?[]const u8 = null,

    encryption_configuration: ?EncryptionConfigurationForRepositoryCreationTemplate = null,

    /// Updates the tag mutability setting for the repository. If this parameter is
    /// omitted,
    /// the default setting of `MUTABLE` will be used which will allow image tags to
    /// be overwritten. If `IMMUTABLE` is specified, all image tags within the
    /// repository will be immutable which will prevent them from being overwritten.
    image_tag_mutability: ?ImageTagMutability = null,

    /// A list of filters that specify which image tags should be excluded from the
    /// repository
    /// creation template's image tag mutability setting.
    image_tag_mutability_exclusion_filters: ?[]const ImageTagMutabilityExclusionFilter = null,

    /// Updates the lifecycle policy associated with the specified repository
    /// creation
    /// template.
    lifecycle_policy: ?[]const u8 = null,

    /// The repository namespace prefix that matches an existing repository creation
    /// template
    /// in the registry. All repositories created using this namespace prefix will
    /// have the
    /// settings defined in this template applied. For example, a prefix of `prod`
    /// would apply to all repositories beginning with `prod/`. This includes a
    /// repository named `prod/team1` as well as a repository named
    /// `prod/repository1`.
    ///
    /// To apply a template to all repositories in your registry that don't have an
    /// associated
    /// creation template, you can use `ROOT` as the prefix.
    prefix: []const u8,

    /// Updates the repository policy created using the template. A repository
    /// policy is a
    /// permissions policy associated with a repository to control access
    /// permissions.
    repository_policy: ?[]const u8 = null,

    /// The metadata to apply to the repository to help you categorize and organize.
    /// Each tag
    /// consists of a key and an optional value, both of which you define. Tag keys
    /// can have a maximum character length of 128 characters, and tag values can
    /// have
    /// a maximum length of 256 characters.
    resource_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .applied_for = "appliedFor",
        .custom_role_arn = "customRoleArn",
        .description = "description",
        .encryption_configuration = "encryptionConfiguration",
        .image_tag_mutability = "imageTagMutability",
        .image_tag_mutability_exclusion_filters = "imageTagMutabilityExclusionFilters",
        .lifecycle_policy = "lifecyclePolicy",
        .prefix = "prefix",
        .repository_policy = "repositoryPolicy",
        .resource_tags = "resourceTags",
    };
};

pub const UpdateRepositoryCreationTemplateOutput = struct {
    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The details of the repository creation template associated with the request.
    repository_creation_template: ?RepositoryCreationTemplate = null,

    pub const json_field_names = .{
        .registry_id = "registryId",
        .repository_creation_template = "repositoryCreationTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRepositoryCreationTemplateInput, options: CallOptions) !UpdateRepositoryCreationTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRepositoryCreationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.UpdateRepositoryCreationTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRepositoryCreationTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateRepositoryCreationTemplateOutput, body, allocator);
}
