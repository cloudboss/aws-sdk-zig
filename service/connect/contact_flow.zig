const aws = @import("aws");

const ContactFlowState = @import("contact_flow_state.zig").ContactFlowState;
const ContactFlowStatus = @import("contact_flow_status.zig").ContactFlowStatus;
const ContactFlowType = @import("contact_flow_type.zig").ContactFlowType;

/// Contains information about a flow.
pub const ContactFlow = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: ?[]const u8 = null,

    /// The JSON string that represents the content of the flow. For an example, see
    /// [Example
    /// flow in Amazon Connect Flow
    /// language](https://docs.aws.amazon.com/connect/latest/APIReference/flow-language-example.html).
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256000.
    content: ?[]const u8 = null,

    /// The description of the flow.
    description: ?[]const u8 = null,

    /// Indicates the checksum value of the flow content.
    flow_content_sha_256: ?[]const u8 = null,

    /// The identifier of the flow.
    id: ?[]const u8 = null,

    /// The region in which the flow was last modified
    last_modified_region: ?[]const u8 = null,

    /// The time at which the flow was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the flow.
    name: ?[]const u8 = null,

    /// The type of flow.
    state: ?ContactFlowState = null,

    /// The status of the flow.
    status: ?ContactFlowStatus = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the flow. For descriptions of the available types, see [Choose a
    /// flow
    /// type](https://docs.aws.amazon.com/connect/latest/adminguide/create-contact-flow.html#contact-flow-types) in the
    /// *Amazon Connect Administrator Guide*.
    @"type": ?ContactFlowType = null,

    /// The identifier of the flow version.
    version: ?i64 = null,

    /// The description of the flow version.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .description = "Description",
        .flow_content_sha_256 = "FlowContentSha256",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .state = "State",
        .status = "Status",
        .tags = "Tags",
        .@"type" = "Type",
        .version = "Version",
        .version_description = "VersionDescription",
    };
};
