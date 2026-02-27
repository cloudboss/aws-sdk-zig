const ObjectLambdaTransformationConfigurationAction = @import("object_lambda_transformation_configuration_action.zig").ObjectLambdaTransformationConfigurationAction;
const ObjectLambdaContentTransformation = @import("object_lambda_content_transformation.zig").ObjectLambdaContentTransformation;

/// A configuration used when creating an Object Lambda Access Point
/// transformation.
pub const ObjectLambdaTransformationConfiguration = struct {
    /// A container for the action of an Object Lambda Access Point configuration.
    /// Valid inputs are
    /// `GetObject`, `ListObjects`, `HeadObject`, and
    /// `ListObjectsV2`.
    actions: []const ObjectLambdaTransformationConfigurationAction,

    /// A container for the content transformation of an Object Lambda Access Point
    /// configuration.
    content_transformation: ObjectLambdaContentTransformation,
};
