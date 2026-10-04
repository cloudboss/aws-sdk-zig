const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ParameterTier = @import("parameter_tier.zig").ParameterTier;
const ParameterType = @import("parameter_type.zig").ParameterType;

pub const PutParameterInput = struct {
    /// A regular expression used to validate the parameter value. For example, for
    /// String types
    /// with values restricted to numbers, you can specify the following:
    /// AllowedPattern=^\d+$
    allowed_pattern: ?[]const u8 = null,

    /// The data type for a `String` parameter. Supported data types include plain
    /// text
    /// and Amazon Machine Image (AMI) IDs.
    ///
    /// **The following data type values are supported.**
    ///
    /// * `text`
    ///
    /// * `aws:ec2:image`
    ///
    /// * `aws:ssm:integration`
    ///
    /// When you create a `String` parameter and specify `aws:ec2:image`,
    /// Amazon Web Services Systems Manager validates the parameter value is in the
    /// required format, such as
    /// `ami-12345abcdeEXAMPLE`, and that the specified AMI is available in your
    /// Amazon Web Services account.
    ///
    /// If the action is successful, the service sends back an HTTP 200 response
    /// which indicates a
    /// successful `PutParameter` call for all cases except for data type
    /// `aws:ec2:image`. If you call `PutParameter` with
    /// `aws:ec2:image` data type, a successful HTTP 200 response does not guarantee
    /// that
    /// your parameter was successfully created or updated. The `aws:ec2:image`
    /// value is
    /// validated asynchronously, and the `PutParameter` call returns before the
    /// validation
    /// is complete. If you submit an invalid AMI value, the PutParameter operation
    /// will return success,
    /// but the asynchronous validation will fail and the parameter will not be
    /// created or updated. To
    /// monitor whether your `aws:ec2:image` parameters are created successfully,
    /// see [Setting
    /// up notifications or trigger actions based on Parameter Store
    /// events](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-cwe.html). For more
    /// information about AMI format validation , see [Native parameter
    /// support for Amazon Machine Image
    /// IDs](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-ec2-aliases.html).
    data_type: ?[]const u8 = null,

    /// Information about the parameter that you want to add to the system. Optional
    /// but
    /// recommended.
    ///
    /// Don't enter personally identifiable information in this field.
    description: ?[]const u8 = null,

    /// The Key Management Service (KMS) ID that you want to use to encrypt a
    /// parameter. Use a custom key for better security. Required for parameters
    /// that use the `SecureString` data type.
    ///
    /// If you don't specify a key ID, the system uses the default key associated
    /// with your
    /// Amazon Web Services account, which is not as secure as using a custom key.
    ///
    /// * To use a custom KMS key, choose the `SecureString`
    /// data type with the `Key ID` parameter.
    key_id: ?[]const u8 = null,

    /// The fully qualified name of the parameter that you want to create or update.
    ///
    /// You can't enter the Amazon Resource Name (ARN) for a parameter, only the
    /// parameter name
    /// itself.
    ///
    /// The fully qualified name includes the complete hierarchy of the parameter
    /// path and name. For
    /// parameters in a hierarchy, you must include a leading forward slash
    /// character (/) when you create
    /// or reference a parameter. For example: `/Dev/DBServer/MySQL/db-string13`
    ///
    /// Naming Constraints:
    ///
    /// * Parameter names are case sensitive.
    ///
    /// * A parameter name must be unique within an Amazon Web Services Region
    ///
    /// * A parameter name can't be prefixed with "`aws`" or "`ssm`"
    /// (case-insensitive).
    ///
    /// * Parameter names can include only the following symbols and letters:
    /// `a-zA-Z0-9_.-`
    ///
    /// In addition, the slash character ( / ) is used to delineate hierarchies in
    /// parameter
    /// names. For example: `/Dev/Production/East/Project-ABC/MyParameter`
    ///
    /// * Parameter names can't contain spaces. The service removes any spaces
    ///   specified for
    /// the beginning or end of a parameter name. If the specified name for a
    /// parameter contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    ///
    /// * Parameter hierarchies are limited to a maximum depth of fifteen levels.
    ///
    /// For additional information about valid values for parameter names, see
    /// [Creating Systems Manager
    /// parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-su-create.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// The reported maximum length of 2048 characters for a parameter name includes
    /// 1037
    /// characters that are reserved for internal use by Systems Manager. The
    /// maximum length for a parameter name
    /// that you specify is 1011 characters.
    ///
    /// This count of 1011 characters includes the characters in the ARN that
    /// precede the name you
    /// specify. This ARN length will vary depending on your partition and Region.
    /// For example, the
    /// following 45 characters count toward the 1011 character maximum for a
    /// parameter created in the
    /// US East (Ohio) Region: `arn:aws:ssm:us-east-2:111122223333:parameter/`.
    name: []const u8,

    /// Overwrite an existing parameter. The default value is `false`.
    overwrite: ?bool = null,

    /// One or more policies to apply to a parameter. This operation takes a JSON
    /// array. Parameter
    /// Store, a tool in Amazon Web Services Systems Manager supports the following
    /// policy types:
    ///
    /// Expiration: This policy deletes the parameter after it expires. When you
    /// create the policy,
    /// you specify the expiration date. You can update the expiration date and time
    /// by updating the
    /// policy. Updating the *parameter* doesn't affect the expiration date and
    /// time.
    /// When the expiration time is reached, Parameter Store deletes the parameter.
    ///
    /// ExpirationNotification: This policy initiates an event in Amazon CloudWatch
    /// Events that
    /// notifies you about the expiration. By using this policy, you can receive
    /// notification before or
    /// after the expiration time is reached, in units of days or hours.
    ///
    /// NoChangeNotification: This policy initiates a CloudWatch Events event if a
    /// parameter hasn't
    /// been modified for a specified period of time. This policy type is useful
    /// when, for example, a
    /// secret needs to be changed within a period of time, but it hasn't been
    /// changed.
    ///
    /// All existing policies are preserved until you send new policies or an empty
    /// policy. For more
    /// information about parameter policies, see [Assigning parameter
    /// policies](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html).
    policies: ?[]const u8 = null,

    /// Optional metadata that you assign to a resource. Tags enable you to
    /// categorize a resource in
    /// different ways, such as by purpose, owner, or environment. For example, you
    /// might want to tag a
    /// Systems Manager parameter to identify the type of resource to which it
    /// applies, the environment, or the
    /// type of configuration data referenced by the parameter. In this case, you
    /// could specify the
    /// following key-value pairs:
    ///
    /// * `Key=Resource,Value=S3bucket`
    ///
    /// * `Key=OS,Value=Windows`
    ///
    /// * `Key=ParameterType,Value=LicenseKey`
    ///
    /// To add tags to an existing Systems Manager parameter, use the
    /// AddTagsToResource
    /// operation.
    tags: ?[]const Tag = null,

    /// The parameter tier to assign to a parameter.
    ///
    /// Parameter Store offers a standard tier and an advanced tier for parameters.
    /// Standard
    /// parameters have a content size limit of 4 KB and can't be configured to use
    /// parameter policies.
    /// You can create a maximum of 10,000 standard parameters for each Region in an
    /// Amazon Web Services account.
    /// Standard parameters are offered at no additional cost.
    ///
    /// Advanced parameters have a content size limit of 8 KB and can be configured
    /// to use parameter
    /// policies. You can create a maximum of 100,000 advanced parameters for each
    /// Region in an
    /// Amazon Web Services account. Advanced parameters incur a charge. For more
    /// information, see [Managing
    /// parameter
    /// tiers](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// You can change a standard parameter to an advanced parameter any time. But
    /// you can't revert
    /// an advanced parameter to a standard parameter. Reverting an advanced
    /// parameter to a standard
    /// parameter would result in data loss because the system would truncate the
    /// size of the parameter
    /// from 8 KB to 4 KB. Reverting would also remove any policies attached to the
    /// parameter. Lastly,
    /// advanced parameters use a different form of encryption than standard
    /// parameters.
    ///
    /// If you no longer need an advanced parameter, or if you no longer want to
    /// incur charges for
    /// an advanced parameter, you must delete it and recreate it as a new standard
    /// parameter.
    ///
    /// **Using the Default Tier Configuration**
    ///
    /// In `PutParameter` requests, you can specify the tier to create the parameter
    /// in.
    /// Whenever you specify a tier in the request, Parameter Store creates or
    /// updates the parameter
    /// according to that request. However, if you don't specify a tier in a
    /// request, Parameter Store
    /// assigns the tier based on the current Parameter Store default tier
    /// configuration.
    ///
    /// The default tier when you begin using Parameter Store is the
    /// standard-parameter tier. If you
    /// use the advanced-parameter tier, you can specify one of the following as the
    /// default:
    ///
    /// * **Advanced**: With this option, Parameter Store evaluates all
    /// requests as advanced parameters.
    ///
    /// * **Intelligent-Tiering**: With this option, Parameter Store
    /// evaluates each request to determine if the parameter is standard or
    /// advanced.
    ///
    /// If the request doesn't include any options that require an advanced
    /// parameter, the
    /// parameter is created in the standard-parameter tier. If one or more options
    /// requiring an
    /// advanced parameter are included in the request, Parameter Store create a
    /// parameter in the
    /// advanced-parameter tier.
    ///
    /// This approach helps control your parameter-related costs by always creating
    /// standard
    /// parameters unless an advanced parameter is necessary.
    ///
    /// Options that require an advanced parameter include the following:
    ///
    /// * The content size of the parameter is more than 4 KB.
    ///
    /// * The parameter uses a parameter policy.
    ///
    /// * More than 10,000 parameters already exist in your Amazon Web Services
    ///   account in the current
    /// Amazon Web Services Region.
    ///
    /// For more information about configuring the default tier option, see
    /// [Specifying a default parameter
    /// tier](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html#ps-default-tier) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    tier: ?ParameterTier = null,

    /// The type of parameter that you want to create.
    ///
    /// `SecureString` isn't currently supported for CloudFormation templates.
    ///
    /// Items in a `StringList` must be separated by a comma (,). You can't
    /// use other punctuation or special character to escape items in the list. If
    /// you have a parameter
    /// value that requires a comma, then use the `String` data type.
    ///
    /// Specifying a parameter type isn't required when updating a parameter. You
    /// must specify a
    /// parameter type when creating a parameter.
    @"type": ?ParameterType = null,

    /// The parameter value that you want to add to the system. Standard parameters
    /// have a value
    /// limit of 4 KB. Advanced parameters have a value limit of 8 KB.
    ///
    /// Parameters can't be referenced or nested in the values of other parameters.
    /// You can't
    /// include values wrapped in double brackets `{{}}` or
    /// `{{ssm:*parameter-name*}}` in a parameter value.
    value: []const u8,

    pub const json_field_names = .{
        .allowed_pattern = "AllowedPattern",
        .data_type = "DataType",
        .description = "Description",
        .key_id = "KeyId",
        .name = "Name",
        .overwrite = "Overwrite",
        .policies = "Policies",
        .tags = "Tags",
        .tier = "Tier",
        .@"type" = "Type",
        .value = "Value",
    };
};

pub const PutParameterOutput = struct {
    /// The tier assigned to the parameter.
    tier: ?ParameterTier = null,

    /// The new version number of a parameter. If you edit a parameter value,
    /// Parameter Store
    /// automatically creates a new version and assigns this new version a unique
    /// ID. You can reference a
    /// parameter version ID in API operations or in Systems Manager documents (SSM
    /// documents). By default, if you
    /// don't specify a specific version, the system returns the latest parameter
    /// value when a parameter
    /// is called.
    version: ?i64 = null,

    pub const json_field_names = .{
        .tier = "Tier",
        .version = "Version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutParameterInput, options: CallOptions) !PutParameterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutParameterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.PutParameter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutParameterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutParameterOutput, body, allocator);
}
