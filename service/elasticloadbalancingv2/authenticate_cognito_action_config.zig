const aws = @import("aws");

const AuthenticateCognitoActionConditionalBehaviorEnum = @import("authenticate_cognito_action_conditional_behavior_enum.zig").AuthenticateCognitoActionConditionalBehaviorEnum;

/// Request parameters to use when integrating with Amazon Cognito to
/// authenticate
/// users.
pub const AuthenticateCognitoActionConfig = struct {
    /// The query parameters (up to 10) to include in the redirect request to the
    /// authorization
    /// endpoint.
    authentication_request_extra_params: ?[]const aws.map.StringMapEntry = null,

    /// The behavior if the user is not authenticated. The following are possible
    /// values:
    ///
    /// * deny`` - Return an HTTP 401 Unauthorized error.
    ///
    /// * allow`` - Allow the request to be forwarded to the target.
    ///
    /// * authenticate`` - Redirect the request to the IdP authorization endpoint.
    ///   This is
    /// the default value.
    on_unauthenticated_request: ?AuthenticateCognitoActionConditionalBehaviorEnum = null,

    /// The set of user claims to be requested from the IdP. The default is
    /// `openid`.
    ///
    /// To verify which scope values your IdP supports and how to separate multiple
    /// values, see
    /// the documentation for your IdP.
    scope: ?[]const u8 = null,

    /// The name of the cookie used to maintain session information. The default is
    /// AWSELBAuthSessionCookie.
    session_cookie_name: ?[]const u8 = null,

    /// The maximum duration of the authentication session, in seconds. The default
    /// is 604800
    /// seconds (7 days).
    session_timeout: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Cognito user pool.
    user_pool_arn: []const u8,

    /// The ID of the Amazon Cognito user pool client.
    user_pool_client_id: []const u8,

    /// The domain prefix or fully-qualified domain name of the Amazon Cognito user
    /// pool.
    user_pool_domain: []const u8,
};
