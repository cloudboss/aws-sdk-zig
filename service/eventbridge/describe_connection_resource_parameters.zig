/// The parameters for EventBridge to use when invoking the resource endpoint.
pub const DescribeConnectionResourceParameters = struct {
    /// For connections to private APIs, the Amazon Resource Name (ARN) of the
    /// resource association EventBridge created between the connection and the
    /// private API's resource configuration.
    ///
    /// For more information, see [
    /// Managing service network resource associations for
    /// connections](https://docs.aws.amazon.com/eventbridge/latest/userguide/connection-private.html#connection-private-snra) in the *
    /// Amazon EventBridge User Guide*
    /// .
    resource_association_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the resource configuration for the private
    /// API.
    resource_configuration_arn: []const u8,

    pub const json_field_names = .{
        .resource_association_arn = "ResourceAssociationArn",
        .resource_configuration_arn = "ResourceConfigurationArn",
    };
};
