/// The Amazon Quick Suite configuration for an Amazon Q Business application
/// that uses Quick Suite as the identity provider. For more information, see
/// [Creating an Amazon Quick Suite integrated
/// application](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/create-quicksight-integrated-application.html).
pub const QuickSightConfiguration = struct {
    /// The Amazon Quick Suite namespace that is used as the identity provider. For
    /// more information about Quick Suite namespaces, see [Namespace
    /// operations](https://docs.aws.amazon.com/quicksight/latest/developerguide/namespace-operations.html).
    client_namespace: []const u8,

    pub const json_field_names = .{
        .client_namespace = "clientNamespace",
    };
};
