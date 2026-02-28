const AuthenticateCognitoActionConfig = @import("authenticate_cognito_action_config.zig").AuthenticateCognitoActionConfig;
const AuthenticateOidcActionConfig = @import("authenticate_oidc_action_config.zig").AuthenticateOidcActionConfig;
const FixedResponseActionConfig = @import("fixed_response_action_config.zig").FixedResponseActionConfig;
const ForwardActionConfig = @import("forward_action_config.zig").ForwardActionConfig;
const JwtValidationActionConfig = @import("jwt_validation_action_config.zig").JwtValidationActionConfig;
const RedirectActionConfig = @import("redirect_action_config.zig").RedirectActionConfig;
const ActionTypeEnum = @import("action_type_enum.zig").ActionTypeEnum;

/// Information about an action.
///
/// Each rule must include exactly one of the following routing actions:
/// `forward`,
/// `fixed-response`, or `redirect`, and it must be the last
/// action to be performed.
///
/// Optionally, a rule for an HTTPS listener can also include one of the
/// following
/// user authentication actions: `authenticate-oidc`,
/// `authenticate-cognito`, or `jwt-validation`.
pub const Action = struct {
    /// [HTTPS listeners] Information for using Amazon Cognito to authenticate
    /// users. Specify only
    /// when `Type` is `authenticate-cognito`.
    authenticate_cognito_config: ?AuthenticateCognitoActionConfig,

    /// [HTTPS listeners] Information about an identity provider that is compliant
    /// with OpenID
    /// Connect (OIDC). Specify only when `Type` is `authenticate-oidc`.
    authenticate_oidc_config: ?AuthenticateOidcActionConfig,

    /// [Application Load Balancer] Information for creating an action that returns
    /// a custom HTTP
    /// response. Specify only when `Type` is `fixed-response`.
    fixed_response_config: ?FixedResponseActionConfig,

    /// Information for creating an action that distributes requests among multiple
    /// target
    /// groups. Specify only when `Type` is `forward`.
    ///
    /// If you specify both `ForwardConfig` and `TargetGroupArn`, you can
    /// specify only one target group using `ForwardConfig` and it must be the same
    /// target group specified in `TargetGroupArn`.
    forward_config: ?ForwardActionConfig,

    /// [HTTPS listeners] Information for validating JWT access tokens in client
    /// requests.
    /// Specify only when `Type` is `jwt-validation`.
    jwt_validation_config: ?JwtValidationActionConfig,

    /// The order for the action. This value is required for rules with multiple
    /// actions. The
    /// action with the lowest value for order is performed first.
    order: ?i32,

    /// [Application Load Balancer] Information for creating a redirect action.
    /// Specify only when
    /// `Type` is `redirect`.
    redirect_config: ?RedirectActionConfig,

    /// The Amazon Resource Name (ARN) of the target group. Specify only when `Type`
    /// is
    /// `forward` and you want to route to a single target group. To route to
    /// multiple
    /// target groups, you must use `ForwardConfig` instead.
    target_group_arn: ?[]const u8,

    /// The type of action.
    @"type": ActionTypeEnum,
};
