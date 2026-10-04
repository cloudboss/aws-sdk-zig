const aws = @import("aws");

const DataClassificationDetails = @import("data_classification_details.zig").DataClassificationDetails;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const ResourceOwner = @import("resource_owner.zig").ResourceOwner;
const Partition = @import("partition.zig").Partition;
const CloudProviderName = @import("cloud_provider_name.zig").CloudProviderName;

/// A resource related to a finding.
pub const Resource = struct {
    /// The Amazon Resource Name (ARN) of the application that is related to a
    /// finding.
    application_arn: ?[]const u8 = null,

    /// The name of the application that is related to a finding.
    application_name: ?[]const u8 = null,

    /// Contains information about sensitive data that was detected on the resource.
    data_classification: ?DataClassificationDetails = null,

    /// Additional details about the resource related to a finding.
    details: ?ResourceDetails = null,

    /// The canonical identifier for the given resource type.
    id: []const u8,

    /// Information about the account and organization that own the resource.
    owner: ?ResourceOwner = null,

    /// The canonical Amazon Web Services partition name that the Region is assigned
    /// to.
    partition: ?Partition = null,

    /// The cloud provider that the resource belongs to. Valid values are `AWS` and
    /// `Azure`.
    provider: ?CloudProviderName = null,

    /// The canonical Amazon Web Services external Region name where this resource
    /// is located.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 16.
    region: ?[]const u8 = null,

    /// Identifies the role of the resource in the finding. A resource is either the
    /// actor or target of the finding activity,
    resource_role: ?[]const u8 = null,

    /// A list of Amazon Web Services tags associated with a resource at the time
    /// the finding was
    /// processed. Tags must follow [Amazon Web Services tag naming limits and
    /// requirements](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html#tag-conventions).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the resource that details are provided for. If possible, set
    /// `Type` to one of the supported resource types. For example, if the resource
    /// is an EC2 instance, then set `Type` to `AwsEc2Instance`.
    ///
    /// If the resource does not match any of the provided types, then set `Type` to
    /// `Other`.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256.
    @"type": []const u8,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .application_name = "ApplicationName",
        .data_classification = "DataClassification",
        .details = "Details",
        .id = "Id",
        .owner = "Owner",
        .partition = "Partition",
        .provider = "Provider",
        .region = "Region",
        .resource_role = "ResourceRole",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
