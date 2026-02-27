const aws = @import("aws");

const GeneratedTemplateResourceStatus = @import("generated_template_resource_status.zig").GeneratedTemplateResourceStatus;
const WarningDetail = @import("warning_detail.zig").WarningDetail;

/// Details about a resource in a generated template
pub const ResourceDetail = struct {
    /// The logical id for this resource in the final generated template.
    logical_resource_id: ?[]const u8,

    /// A list of up to 256 key-value pairs that identifies the resource in the
    /// generated template.
    /// The key is the name of one of the primary identifiers for the resource.
    /// (Primary identifiers are
    /// specified in the `primaryIdentifier` list in the resource schema.) The value
    /// is the
    /// value of that primary identifier. For example, for a `AWS::DynamoDB::Table`
    /// resource,
    /// the primary identifiers is `TableName` so the key-value pair could be
    /// `"TableName": "MyDDBTable"`. For more information, see
    /// [primaryIdentifier](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html#schema-properties-primaryidentifier) in the *CloudFormation Command Line Interface (CLI) User Guide*.
    resource_identifier: ?[]const aws.map.StringMapEntry,

    /// Status of the processing of a resource in a generated template.
    ///
    /// **
    ///
    /// InProgress
    ///
    /// **
    ///
    /// The resource processing is still in progress.
    ///
    /// **
    ///
    /// Complete
    ///
    /// **
    ///
    /// The resource processing is complete.
    ///
    /// **
    ///
    /// Pending
    ///
    /// **
    ///
    /// The resource processing is pending.
    ///
    /// **
    ///
    /// Failed
    ///
    /// **
    ///
    /// The resource processing has failed.
    resource_status: ?GeneratedTemplateResourceStatus,

    /// The reason for the resource detail, providing more information if a failure
    /// happened.
    resource_status_reason: ?[]const u8,

    /// The type of the resource, such as `AWS::DynamoDB::Table`. For the list of
    /// supported resources, see [Resource type
    /// support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html) In the
    /// *CloudFormation User Guide*
    resource_type: ?[]const u8,

    /// The warnings generated for this resource.
    warnings: ?[]const WarningDetail,
};
