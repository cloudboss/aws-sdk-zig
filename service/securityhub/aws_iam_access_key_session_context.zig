const AwsIamAccessKeySessionContextAttributes = @import("aws_iam_access_key_session_context_attributes.zig").AwsIamAccessKeySessionContextAttributes;
const AwsIamAccessKeySessionContextSessionIssuer = @import("aws_iam_access_key_session_context_session_issuer.zig").AwsIamAccessKeySessionContextSessionIssuer;

/// Provides information about the session that the key was used for.
pub const AwsIamAccessKeySessionContext = struct {
    /// Attributes of the session that the key was used for.
    attributes: ?AwsIamAccessKeySessionContextAttributes = null,

    /// Information about the entity that created the session.
    session_issuer: ?AwsIamAccessKeySessionContextSessionIssuer = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .session_issuer = "SessionIssuer",
    };
};
