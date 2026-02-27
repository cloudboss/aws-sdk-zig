const CustomEmailLambdaVersionConfigType = @import("custom_email_lambda_version_config_type.zig").CustomEmailLambdaVersionConfigType;
const CustomSMSLambdaVersionConfigType = @import("custom_sms_lambda_version_config_type.zig").CustomSMSLambdaVersionConfigType;
const InboundFederationLambdaType = @import("inbound_federation_lambda_type.zig").InboundFederationLambdaType;
const PreTokenGenerationVersionConfigType = @import("pre_token_generation_version_config_type.zig").PreTokenGenerationVersionConfigType;

/// A collection of user pool Lambda triggers. Amazon Cognito invokes triggers
/// at several possible
/// stages of user pool operations. Triggers can modify the outcome of the
/// operations that
/// invoked them.
pub const LambdaConfigType = struct {
    /// The configuration of a create auth challenge Lambda trigger, one of three
    /// triggers in
    /// the sequence of the [custom authentication challenge
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    create_auth_challenge: ?[]const u8,

    /// The configuration of a custom email sender Lambda trigger. This trigger
    /// routes all
    /// email notifications from a user pool to a Lambda function that delivers the
    /// message using
    /// custom logic.
    custom_email_sender: ?CustomEmailLambdaVersionConfigType,

    /// A custom message Lambda trigger. This trigger is an opportunity to customize
    /// all SMS
    /// and email messages from your user pool. When a custom message trigger is
    /// active, your
    /// user pool routes all messages to a Lambda function that returns a
    /// runtime-customized
    /// message subject and body for your user pool to deliver to a user.
    custom_message: ?[]const u8,

    /// The configuration of a custom SMS sender Lambda trigger. This trigger routes
    /// all SMS
    /// notifications from a user pool to a Lambda function that delivers the
    /// message using
    /// custom logic.
    custom_sms_sender: ?CustomSMSLambdaVersionConfigType,

    /// The configuration of a define auth challenge Lambda trigger, one of three
    /// triggers in
    /// the sequence of the [custom authentication challenge
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    define_auth_challenge: ?[]const u8,

    /// The configuration of an inbound federation Lambda trigger. This trigger can
    /// transform federated user attributes during the authentication with external
    /// identity providers.
    inbound_federation: ?InboundFederationLambdaType,

    /// The ARN of an [KMS
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys). Amazon Cognito uses the key to encrypt codes and temporary passwords sent to
    /// custom sender Lambda triggers.
    kms_key_id: ?[]const u8,

    /// The configuration of a [post authentication Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-post-authentication.html) in a user pool. This
    /// trigger can take custom actions after a user signs in.
    post_authentication: ?[]const u8,

    /// The configuration of a [post confirmation Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-post-confirmation.html) in a user pool. This
    /// trigger can take custom actions after a user confirms their user account and
    /// their email
    /// address or phone number.
    post_confirmation: ?[]const u8,

    /// The configuration of a [pre authentication
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-authentication.html) in a user pool. This trigger
    /// can evaluate and modify user sign-in events.
    pre_authentication: ?[]const u8,

    /// The configuration of a [pre sign-up Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html) in a user pool. This trigger
    /// evaluates new users and can bypass confirmation, [link a federated user
    /// profile](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-identity-federation-consolidate-users.html), or block sign-up
    /// requests.
    pre_sign_up: ?[]const u8,

    /// The legacy configuration of a [pre token generation Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-token-generation.html) in a user
    /// pool.
    ///
    /// Set this parameter for legacy purposes. If you also set an ARN in
    /// `PreTokenGenerationConfig`, its value must be identical to
    /// `PreTokenGeneration`. For new instances of pre token generation triggers,
    /// set the `LambdaArn` of `PreTokenGenerationConfig`.
    pre_token_generation: ?[]const u8,

    /// The detailed configuration of a [pre token generation Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-token-generation.html) in a user pool. If
    /// you also set an ARN in `PreTokenGeneration`, its value must be identical to
    /// `PreTokenGenerationConfig`.
    pre_token_generation_config: ?PreTokenGenerationVersionConfigType,

    /// The configuration of a [migrate user Lambda
    /// trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-migrate-user.html) in a user pool. This trigger
    /// can create user profiles when users sign in or attempt to reset their
    /// password with
    /// credentials that don't exist yet.
    user_migration: ?[]const u8,

    /// The configuration of a verify auth challenge Lambda trigger, one of three
    /// triggers in
    /// the sequence of the [custom authentication challenge
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).
    verify_auth_challenge_response: ?[]const u8,

    pub const json_field_names = .{
        .create_auth_challenge = "CreateAuthChallenge",
        .custom_email_sender = "CustomEmailSender",
        .custom_message = "CustomMessage",
        .custom_sms_sender = "CustomSMSSender",
        .define_auth_challenge = "DefineAuthChallenge",
        .inbound_federation = "InboundFederation",
        .kms_key_id = "KMSKeyID",
        .post_authentication = "PostAuthentication",
        .post_confirmation = "PostConfirmation",
        .pre_authentication = "PreAuthentication",
        .pre_sign_up = "PreSignUp",
        .pre_token_generation = "PreTokenGeneration",
        .pre_token_generation_config = "PreTokenGenerationConfig",
        .user_migration = "UserMigration",
        .verify_auth_challenge_response = "VerifyAuthChallengeResponse",
    };
};
