const aws = @import("aws");

/// A scanned resource returned by `ListResourceScanResources` or
/// `ListResourceScanRelatedResources`.
pub const ScannedResource = struct {
    /// If `true`, the resource is managed by a CloudFormation stack.
    managed_by_stack: ?bool = null,

    /// A list of up to 256 key-value pairs that identifies for the scanned
    /// resource. The key is the
    /// name of one of the primary identifiers for the resource. (Primary
    /// identifiers are specified in
    /// the `primaryIdentifier` list in the resource schema.) The value is the value
    /// of that
    /// primary identifier. For example, for a `AWS::DynamoDB::Table` resource, the
    /// primary
    /// identifiers is `TableName` so the key-value pair could be `"TableName":
    /// "MyDDBTable"`. For more information, see
    /// [primaryIdentifier](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html#schema-properties-primaryidentifier) in the *CloudFormation Command Line Interface (CLI) User Guide*.
    resource_identifier: ?[]const aws.map.StringMapEntry = null,

    /// The type of the resource, such as `AWS::DynamoDB::Table`. For the list of
    /// supported resources, see [Resource type
    /// support for imports and drift
    /// detection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resource-import-supported-resources.html) In the
    /// *CloudFormation User Guide*
    resource_type: ?[]const u8 = null,
};
