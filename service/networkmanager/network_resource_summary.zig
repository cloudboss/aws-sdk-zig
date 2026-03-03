/// Describes a network resource.
pub const NetworkResourceSummary = struct {
    /// Information about the resource, in JSON format. Network Manager gets this
    /// information by describing the resource using its Describe API call.
    definition: ?[]const u8 = null,

    /// Indicates whether this is a middlebox appliance.
    is_middlebox: bool = false,

    /// The value for the Name tag.
    name_tag: ?[]const u8 = null,

    /// The ARN of the gateway.
    registered_gateway_arn: ?[]const u8 = null,

    /// The ARN of the resource.
    resource_arn: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .definition = "Definition",
        .is_middlebox = "IsMiddlebox",
        .name_tag = "NameTag",
        .registered_gateway_arn = "RegisteredGatewayArn",
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
    };
};
