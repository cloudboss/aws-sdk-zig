const aws = @import("aws");

const DataClassificationDetails = @import("data_classification_details.zig").DataClassificationDetails;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;
const Partition = @import("partition.zig").Partition;

/// A resource related to a finding.
pub const Resource = struct {
    /// The Amazon Resource Name (ARN) of the application that is related to a
    /// finding.
    application_arn: ?[]const u8,

    /// The name of the application that is related to a finding.
    application_name: ?[]const u8,

    /// Contains information about sensitive data that was detected on the resource.
    data_classification: ?DataClassificationDetails,

    /// Additional details about the resource related to a finding.
    details: ?ResourceDetails,

    /// The canonical identifier for the given resource type.
    id: []const u8,

    /// The canonical Amazon Web Services partition name that the Region is assigned
    /// to.
    partition: ?Partition,

    /// The canonical Amazon Web Services external Region name where this resource
    /// is located.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 16.
    region: ?[]const u8,

    /// Identifies the role of the resource in the finding. A resource is either the
    /// actor or target of the finding activity,
    resource_role: ?[]const u8,

    /// A list of Amazon Web Services tags associated with a resource at the time
    /// the finding was
    /// processed. Tags must follow [Amazon Web Services tag naming limits and
    /// requirements](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html#tag-conventions).
    tags: ?[]const aws.map.StringMapEntry,

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
        .partition = "Partition",
        .region = "Region",
        .resource_role = "ResourceRole",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
