const FederationMode = @import("federation_mode.zig").FederationMode;
const FederationParameters = @import("federation_parameters.zig").FederationParameters;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;

/// Represents an FinSpace environment.
pub const Environment = struct {
    /// The ID of the AWS account in which the FinSpace environment is created.
    aws_account_id: ?[]const u8 = null,

    /// The AWS account ID of the dedicated service account associated with your
    /// FinSpace
    /// environment.
    dedicated_service_account_id: ?[]const u8 = null,

    /// The description of the FinSpace environment.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of your FinSpace environment.
    environment_arn: ?[]const u8 = null,

    /// The identifier of the FinSpace environment.
    environment_id: ?[]const u8 = null,

    /// The sign-in URL for the web application of your FinSpace environment.
    environment_url: ?[]const u8 = null,

    /// The authentication mode for the environment.
    federation_mode: ?FederationMode = null,

    /// Configuration information when authentication mode is FEDERATED.
    federation_parameters: ?FederationParameters = null,

    /// The KMS key id used to encrypt in the FinSpace environment.
    kms_key_id: ?[]const u8 = null,

    /// The name of the FinSpace environment.
    name: ?[]const u8 = null,

    /// The URL of the integrated FinSpace notebook environment in your web
    /// application.
    sage_maker_studio_domain_url: ?[]const u8 = null,

    /// The current status of creation of the FinSpace environment.
    status: ?EnvironmentStatus = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .dedicated_service_account_id = "dedicatedServiceAccountId",
        .description = "description",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .environment_url = "environmentUrl",
        .federation_mode = "federationMode",
        .federation_parameters = "federationParameters",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .sage_maker_studio_domain_url = "sageMakerStudioDomainUrl",
        .status = "status",
    };
};
