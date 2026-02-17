const aws = @import("aws");
const std = @import("std");


const batch_get_secret_value = @import("batch_get_secret_value.zig");
const cancel_rotate_secret = @import("cancel_rotate_secret.zig");
const create_secret = @import("create_secret.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_secret = @import("delete_secret.zig");
const describe_secret = @import("describe_secret.zig");
const get_random_password = @import("get_random_password.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_secret_value = @import("get_secret_value.zig");
const list_secret_version_ids = @import("list_secret_version_ids.zig");
const list_secrets = @import("list_secrets.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const put_secret_value = @import("put_secret_value.zig");
const remove_regions_from_replication = @import("remove_regions_from_replication.zig");
const replicate_secret_to_regions = @import("replicate_secret_to_regions.zig");
const restore_secret = @import("restore_secret.zig");
const rotate_secret = @import("rotate_secret.zig");
const stop_replication_to_replica = @import("stop_replication_to_replica.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_secret = @import("update_secret.zig");
const update_secret_version_stage = @import("update_secret_version_stage.zig");
const validate_resource_policy = @import("validate_resource_policy.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Retrieves the contents of the encrypted fields `SecretString` or
    /// `SecretBinary` for up to 20 secrets. To retrieve a single secret, call
    /// GetSecretValue.
    ///
    /// To choose which secrets to retrieve, you can specify a list of secrets by
    /// name or ARN,
    /// or you can use filters. If Secrets Manager encounters errors such as
    /// `AccessDeniedException` while attempting to retrieve any of the secrets,
    /// you can see the errors in `Errors` in the response.
    ///
    /// Secrets Manager generates CloudTrail
    /// `GetSecretValue` log entries for each secret you request when you call this
    /// action. Do not include sensitive information in request parameters because
    /// it might be
    /// logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions: **
    /// `secretsmanager:BatchGetSecretValue`, and you must have
    /// `secretsmanager:GetSecretValue` for each secret. If you use filters, you
    /// must also have `secretsmanager:ListSecrets`. If the secrets are encrypted
    /// using customer-managed keys instead of the Amazon Web Services managed key
    /// `aws/secretsmanager`, then you also need `kms:Decrypt`
    /// permissions for the keys. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn batchGetSecretValue(self: *Self, input: batch_get_secret_value.BatchGetSecretValueInput, options: batch_get_secret_value.Options) !batch_get_secret_value.BatchGetSecretValueOutput {
        return batch_get_secret_value.execute(self, input, options);
    }

    /// Turns off automatic rotation, and if a rotation is currently in progress,
    /// cancels the
    /// rotation.
    ///
    /// If you cancel a rotation in progress, it can leave the `VersionStage`
    /// labels in an unexpected state. You might need to remove the staging label
    /// `AWSPENDING` from the partially created version. You also need to
    /// determine whether to roll back to the previous version of the secret by
    /// moving the
    /// staging label `AWSCURRENT` to the version that has `AWSPENDING`.
    /// To determine which version has a specific staging label, call
    /// ListSecretVersionIds. Then use UpdateSecretVersionStage to change staging
    /// labels. For more information, see [How rotation
    /// works](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotate-secrets_how.html).
    ///
    /// To turn on automatic rotation again, call RotateSecret.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:CancelRotateSecret`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn cancelRotateSecret(self: *Self, input: cancel_rotate_secret.CancelRotateSecretInput, options: cancel_rotate_secret.Options) !cancel_rotate_secret.CancelRotateSecretOutput {
        return cancel_rotate_secret.execute(self, input, options);
    }

    /// Creates a new secret. A *secret* can be a password, a set of
    /// credentials such as a user name and password, an OAuth token, or other
    /// secret
    /// information that you store in an encrypted form in Secrets Manager. The
    /// secret also includes the
    /// connection information to access a database or other service, which Secrets
    /// Manager doesn't
    /// encrypt. A secret in Secrets Manager consists of both the protected secret
    /// data and the important
    /// information needed to manage the secret.
    ///
    /// For secrets that use *managed rotation*, you need to create the
    /// secret through the managing service. For more information, see [Secrets
    /// Manager secrets
    /// managed by other Amazon Web Services
    /// services](https://docs.aws.amazon.com/secretsmanager/latest/userguide/service-linked-secrets.html).
    ///
    /// For information about creating a secret in the console, see [Create a
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_create-basic-secret.html).
    ///
    /// To create a secret, you can provide the secret value to be encrypted in
    /// either the
    /// `SecretString` parameter or the `SecretBinary` parameter, but
    /// not both. If you include `SecretString` or `SecretBinary` then
    /// Secrets Manager creates an initial secret version and automatically attaches
    /// the staging label
    /// `AWSCURRENT` to it.
    ///
    /// For database credentials you want to rotate, for Secrets Manager to be able
    /// to rotate the
    /// secret, you must make sure the JSON you store in the `SecretString` matches
    /// the [JSON
    /// structure of a database
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_secret_json_structure.html).
    ///
    /// If you don't specify an KMS encryption key, Secrets Manager uses the Amazon
    /// Web Services managed key
    /// `aws/secretsmanager`. If this key doesn't already exist in your account,
    /// then Secrets Manager creates it for you automatically. All users and roles
    /// in the Amazon Web Services account
    /// automatically have access to use `aws/secretsmanager`. Creating
    /// `aws/secretsmanager` can result in a one-time significant delay in
    /// returning the result.
    ///
    /// If the secret is in a different Amazon Web Services account from the
    /// credentials calling the API,
    /// then you can't use `aws/secretsmanager` to encrypt the secret, and you must
    /// create and use a customer managed KMS key.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters except
    /// `SecretBinary` or `SecretString` because it might be logged.
    /// For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:CreateSecret`. If you include tags in the
    /// secret, you also need `secretsmanager:TagResource`. To add replica Regions,
    /// you must also have `secretsmanager:ReplicateSecretToRegions`.
    /// For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    ///
    /// To encrypt the secret with a KMS key other than `aws/secretsmanager`, you
    /// need `kms:GenerateDataKey` and `kms:Decrypt` permission to the
    /// key.
    ///
    /// **Important:**
    ///
    /// When you enter commands in a command shell, there is a risk of the command
    /// history being accessed or utilities having access to your command
    /// parameters. This is a concern if the command includes the value of a secret.
    /// Learn how to [Mitigate the risks of using command-line tools to store
    /// Secrets Manager
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security_cli-exposure-risks.html).
    pub fn createSecret(self: *Self, input: create_secret.CreateSecretInput, options: create_secret.Options) !create_secret.CreateSecretOutput {
        return create_secret.execute(self, input, options);
    }

    /// Deletes the resource-based permission policy attached to the secret. To
    /// attach a
    /// policy to a secret, use PutResourcePolicy.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:DeleteResourcePolicy`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn deleteResourcePolicy(self: *Self, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, input, options);
    }

    /// Deletes a secret and all of its versions. You can specify a recovery window
    /// during
    /// which you can restore the secret. The minimum recovery window is 7 days. The
    /// default
    /// recovery window is 30 days. Secrets Manager attaches a `DeletionDate` stamp
    /// to the
    /// secret that specifies the end of the recovery window. At the end of the
    /// recovery window,
    /// Secrets Manager deletes the secret permanently.
    ///
    /// You can't delete a primary secret that is replicated to other Regions. You
    /// must first
    /// delete the replicas using RemoveRegionsFromReplication, and then
    /// delete the primary secret. When you delete a replica, it is deleted
    /// immediately.
    ///
    /// You can't directly delete a version of a secret. Instead, you remove all
    /// staging
    /// labels from the version using UpdateSecretVersionStage. This marks the
    /// version as deprecated, and then Secrets Manager can automatically delete the
    /// version in the
    /// background.
    ///
    /// To determine whether an application still uses a secret, you can create an
    /// Amazon CloudWatch alarm
    /// to alert you to any attempts to access a secret during the recovery window.
    /// For more
    /// information, see [
    /// Monitor secrets scheduled for
    /// deletion](https://docs.aws.amazon.com/secretsmanager/latest/userguide/monitoring_cloudwatch_deleted-secrets.html).
    ///
    /// Secrets Manager performs the permanent secret deletion at the end of the
    /// waiting period as a
    /// background task with low priority. There is no guarantee of a specific time
    /// after the
    /// recovery window for the permanent delete to occur.
    ///
    /// At any time before recovery window ends, you can use RestoreSecret
    /// to remove the `DeletionDate` and cancel the deletion of the secret.
    ///
    /// When a secret is scheduled for deletion, you cannot retrieve the secret
    /// value. You
    /// must first cancel the deletion with RestoreSecret and then you can
    /// retrieve the secret.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:DeleteSecret`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn deleteSecret(self: *Self, input: delete_secret.DeleteSecretInput, options: delete_secret.Options) !delete_secret.DeleteSecretOutput {
        return delete_secret.execute(self, input, options);
    }

    /// Retrieves the details of a secret. It does not include the encrypted secret
    /// value.
    /// Secrets Manager only returns fields that have a value in the response.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:DescribeSecret`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn describeSecret(self: *Self, input: describe_secret.DescribeSecretInput, options: describe_secret.Options) !describe_secret.DescribeSecretOutput {
        return describe_secret.execute(self, input, options);
    }

    /// Generates a random password. We recommend that you specify the maximum
    /// length and
    /// include every character type that the system you are generating a password
    /// for can
    /// support. By default, Secrets Manager uses uppercase and lowercase letters,
    /// numbers, and the
    /// following characters in passwords:
    /// `!\"#$%&'()*+,-./:;?@[\\]^_`{|}~`
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this
    /// action.
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:GetRandomPassword`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn getRandomPassword(self: *Self, input: get_random_password.GetRandomPasswordInput, options: get_random_password.Options) !get_random_password.GetRandomPasswordOutput {
        return get_random_password.execute(self, input, options);
    }

    /// Retrieves the JSON text of the resource-based policy document attached to
    /// the secret.
    /// For more information about permissions policies attached to a secret, see
    /// [Permissions policies attached to a
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_resource-policies.html).
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:GetResourcePolicy`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn getResourcePolicy(self: *Self, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, input, options);
    }

    /// Retrieves the contents of the encrypted fields `SecretString` or
    /// `SecretBinary` from the specified version of a secret, whichever contains
    /// content.
    ///
    /// To retrieve the values for a group of secrets, call BatchGetSecretValue.
    ///
    /// We recommend that you cache your secret values by using client-side caching.
    /// Caching
    /// secrets improves speed and reduces your costs. For more information, see
    /// [Cache secrets for your
    /// applications](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieving-secrets.html).
    ///
    /// To retrieve the previous version of a secret, use `VersionStage` and
    /// specify AWSPREVIOUS. To revert to the previous version of a secret, call
    /// [UpdateSecretVersionStage](https://docs.aws.amazon.com/cli/latest/reference/secretsmanager/update-secret-version-stage.html).
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:GetSecretValue`. If the secret is encrypted
    /// using a customer-managed key instead of the Amazon Web Services managed key
    /// `aws/secretsmanager`, then you also need `kms:Decrypt`
    /// permissions for that key. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn getSecretValue(self: *Self, input: get_secret_value.GetSecretValueInput, options: get_secret_value.Options) !get_secret_value.GetSecretValueOutput {
        return get_secret_value.execute(self, input, options);
    }

    /// Lists the versions of a secret. Secrets Manager uses staging labels to
    /// indicate the different
    /// versions of a secret. For more information, see [ Secrets Manager
    /// concepts:
    /// Versions](https://docs.aws.amazon.com/secretsmanager/latest/userguide/getting-started.html#term_version).
    ///
    /// To list the secrets in the account, use ListSecrets.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:ListSecretVersionIds`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn listSecretVersionIds(self: *Self, input: list_secret_version_ids.ListSecretVersionIdsInput, options: list_secret_version_ids.Options) !list_secret_version_ids.ListSecretVersionIdsOutput {
        return list_secret_version_ids.execute(self, input, options);
    }

    /// Lists the secrets that are stored by Secrets Manager in the Amazon Web
    /// Services account, not including secrets
    /// that are marked for deletion. To see secrets marked for deletion, use the
    /// Secrets Manager
    /// console.
    ///
    /// All Secrets Manager operations are eventually consistent. ListSecrets might
    /// not
    /// reflect changes from the last five minutes. You can get more recent
    /// information for a
    /// specific secret by calling DescribeSecret.
    ///
    /// To list the versions of a secret, use ListSecretVersionIds.
    ///
    /// To retrieve the values for the secrets, call BatchGetSecretValue or
    /// GetSecretValue.
    ///
    /// For information about finding secrets in the console, see [Find secrets in
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_search-secret.html).
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:ListSecrets`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn listSecrets(self: *Self, input: list_secrets.ListSecretsInput, options: list_secrets.Options) !list_secrets.ListSecretsOutput {
        return list_secrets.execute(self, input, options);
    }

    /// Attaches a resource-based permission policy to a secret. A resource-based
    /// policy is
    /// optional. For more information, see [Authentication and access control for
    /// Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html)
    ///
    /// For information about attaching a policy in the console, see [Attach a
    /// permissions policy to a
    /// secret](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_resource-based-policies.html).
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:PutResourcePolicy`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn putResourcePolicy(self: *Self, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, input, options);
    }

    /// Creates a new version of your secret by creating a new encrypted value and
    /// attaching
    /// it to the secret. version can contain a new `SecretString` value or a new
    /// `SecretBinary` value.
    ///
    /// Do not call `PutSecretValue` at a sustained rate of more than once every 10
    /// minutes. When you update the secret value, Secrets Manager creates a new
    /// version of the secret.
    /// Secrets Manager keeps 100 of the most recent versions, but it keeps *all*
    /// secret versions created in the last 24 hours. If you call `PutSecretValue`
    /// more than once every 10 minutes, you will create more versions than Secrets
    /// Manager removes, and
    /// you will reach the quota for secret versions.
    ///
    /// You can specify the staging labels to attach to the new version in
    /// `VersionStages`. If you don't include `VersionStages`, then
    /// Secrets Manager automatically moves the staging label `AWSCURRENT` to this
    /// version. If
    /// this operation creates the first version for the secret, then Secrets
    /// Manager automatically
    /// attaches the staging label `AWSCURRENT` to it. If this operation moves the
    /// staging label `AWSCURRENT` from another version to this version, then
    /// Secrets Manager
    /// also automatically moves the staging label `AWSPREVIOUS` to the version that
    /// `AWSCURRENT` was removed from.
    ///
    /// This operation is idempotent. If you call this operation with a
    /// `ClientRequestToken` that matches an existing version's VersionId, and
    /// you specify the same secret data, the operation succeeds but does nothing.
    /// However, if
    /// the secret data is different, then the operation fails because you can't
    /// modify an
    /// existing version; you can only create new ones.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters except
    /// `SecretBinary`, `SecretString`, or `RotationToken`
    /// because it might be logged. For more information, see [Logging Secrets
    /// Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:PutSecretValue`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    ///
    /// **Important:**
    ///
    /// When you enter commands in a command shell, there is a risk of the command
    /// history being accessed or utilities having access to your command
    /// parameters. This is a concern if the command includes the value of a secret.
    /// Learn how to [Mitigate the risks of using command-line tools to store
    /// Secrets Manager
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security_cli-exposure-risks.html).
    pub fn putSecretValue(self: *Self, input: put_secret_value.PutSecretValueInput, options: put_secret_value.Options) !put_secret_value.PutSecretValueOutput {
        return put_secret_value.execute(self, input, options);
    }

    /// For a secret that is replicated to other Regions, deletes the secret
    /// replicas from the
    /// Regions you specify.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:RemoveRegionsFromReplication`.
    /// For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn removeRegionsFromReplication(self: *Self, input: remove_regions_from_replication.RemoveRegionsFromReplicationInput, options: remove_regions_from_replication.Options) !remove_regions_from_replication.RemoveRegionsFromReplicationOutput {
        return remove_regions_from_replication.execute(self, input, options);
    }

    /// Replicates the secret to a new Regions. See [Multi-Region
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/create-manage-multi-region-secrets.html).
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:ReplicateSecretToRegions`. If the primary
    /// secret is encrypted with a KMS key other than `aws/secretsmanager`, you also
    /// need `kms:Decrypt` permission to the key. To encrypt the replicated secret
    /// with a KMS key other than `aws/secretsmanager`, you need
    /// `kms:GenerateDataKey` and `kms:Encrypt` to the key.
    /// For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn replicateSecretToRegions(self: *Self, input: replicate_secret_to_regions.ReplicateSecretToRegionsInput, options: replicate_secret_to_regions.Options) !replicate_secret_to_regions.ReplicateSecretToRegionsOutput {
        return replicate_secret_to_regions.execute(self, input, options);
    }

    /// Cancels the scheduled deletion of a secret by removing the `DeletedDate`
    /// time stamp. You can access a secret again after it has been restored.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:RestoreSecret`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn restoreSecret(self: *Self, input: restore_secret.RestoreSecretInput, options: restore_secret.Options) !restore_secret.RestoreSecretOutput {
        return restore_secret.execute(self, input, options);
    }

    /// Configures and starts the asynchronous process of rotating the secret. For
    /// information
    /// about rotation, see [Rotate
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html)
    /// in the *Secrets Manager User Guide*. If you include the configuration
    /// parameters, the operation sets the values for the secret and then
    /// immediately starts a
    /// rotation. If you don't include the configuration parameters, the operation
    /// starts a
    /// rotation with the values already stored in the secret.
    ///
    /// When rotation is successful, the `AWSPENDING` staging label might be
    /// attached to the same version as the `AWSCURRENT` version, or it might not be
    /// attached to any version. If the `AWSPENDING` staging label is present but
    /// not
    /// attached to the same version as `AWSCURRENT`, then any later invocation of
    /// `RotateSecret` assumes that a previous rotation request is still in
    /// progress and returns an error. When rotation is unsuccessful, the
    /// `AWSPENDING` staging label might be attached to an empty secret version.
    /// For more information, see [Troubleshoot
    /// rotation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot_rotation.html) in the *Secrets Manager User Guide*.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:RotateSecret`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html). You also
    /// need `lambda:InvokeFunction` permissions on the rotation function. For more
    /// information, see [ Permissions for
    /// rotation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets-required-permissions-function.html).
    pub fn rotateSecret(self: *Self, input: rotate_secret.RotateSecretInput, options: rotate_secret.Options) !rotate_secret.RotateSecretOutput {
        return rotate_secret.execute(self, input, options);
    }

    /// Removes the link between the replica secret and the primary secret and
    /// promotes the
    /// replica to a primary secret in the replica Region.
    ///
    /// You must call this operation from the Region in which you want to promote
    /// the replica
    /// to a primary secret.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:StopReplicationToReplica`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn stopReplicationToReplica(self: *Self, input: stop_replication_to_replica.StopReplicationToReplicaInput, options: stop_replication_to_replica.Options) !stop_replication_to_replica.StopReplicationToReplicaOutput {
        return stop_replication_to_replica.execute(self, input, options);
    }

    /// Attaches tags to a secret. Tags consist of a key name and a value. Tags are
    /// part of
    /// the secret's metadata. They are not associated with specific versions of the
    /// secret.
    /// This operation appends tags to the existing list of tags.
    ///
    /// For tag quotas and naming restrictions, see [Service quotas for
    /// Tagging](https://docs.aws.amazon.com/general/latest/gr/arg.html#taged-reference-quotas) in the *Amazon Web Services General Reference guide*.
    ///
    /// **Important:**
    ///
    /// If you use tags as part of your security strategy, then adding or removing a
    /// tag
    /// can change permissions. If successfully completing this operation would
    /// result in
    /// you losing your permissions for this secret, then the operation is blocked
    /// and
    /// returns an Access Denied error.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:TagResource`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn tagResource(self: *Self, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, input, options);
    }

    /// Removes specific tags from a secret.
    ///
    /// This operation is idempotent. If a requested tag is not attached to the
    /// secret, no
    /// error is returned and the secret metadata is unchanged.
    ///
    /// **Important:**
    ///
    /// If you use tags as part of your security strategy, then removing a tag can
    /// change
    /// permissions. If successfully completing this operation would result in you
    /// losing
    /// your permissions for this secret, then the operation is blocked and returns
    /// an
    /// Access Denied error.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:UntagResource`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn untagResource(self: *Self, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, input, options);
    }

    /// Modifies the details of a secret, including metadata and the secret value.
    /// To change
    /// the secret value, you can also use PutSecretValue.
    ///
    /// To change the rotation configuration of a secret, use RotateSecret
    /// instead.
    ///
    /// To change a secret so that it is managed by another service, you need to
    /// recreate the
    /// secret in that service. See [Secrets Manager secrets
    /// managed by other Amazon Web Services
    /// services](https://docs.aws.amazon.com/secretsmanager/latest/userguide/service-linked-secrets.html).
    ///
    /// We recommend you avoid calling `UpdateSecret` at a sustained rate of more
    /// than once every 10 minutes. When you call `UpdateSecret` to update the
    /// secret
    /// value, Secrets Manager creates a new version of the secret. Secrets Manager
    /// removes outdated versions when
    /// there are more than 100, but it does not remove versions created less than
    /// 24 hours ago.
    /// If you update the secret value more than once every 10 minutes, you create
    /// more versions
    /// than Secrets Manager removes, and you will reach the quota for secret
    /// versions.
    ///
    /// If you include `SecretString` or `SecretBinary` to create a new
    /// secret version, Secrets Manager automatically moves the staging label
    /// `AWSCURRENT` to
    /// the new version. Then it attaches the label `AWSPREVIOUS` to the version
    /// that
    /// `AWSCURRENT` was removed from.
    ///
    /// If you call this operation with a `ClientRequestToken` that matches an
    /// existing version's `VersionId`, the operation results in an error. You can't
    /// modify an existing version, you can only create a new version. To remove a
    /// version,
    /// remove all staging labels from it. See UpdateSecretVersionStage.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters except
    /// `SecretBinary` or `SecretString` because it might be logged.
    /// For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:UpdateSecret`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html). If you use a
    /// customer managed key, you must also have `kms:GenerateDataKey`,
    /// `kms:Encrypt`, and `kms:Decrypt` permissions on the key. If
    /// you change the KMS key and you don't have `kms:Encrypt` permission to the
    /// new
    /// key, Secrets Manager does not re-encrypt existing secret versions with the
    /// new key. For more
    /// information, see [ Secret encryption
    /// and
    /// decryption](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security-encryption.html).
    ///
    /// **Important:**
    ///
    /// When you enter commands in a command shell, there is a risk of the command
    /// history being accessed or utilities having access to your command
    /// parameters. This is a concern if the command includes the value of a secret.
    /// Learn how to [Mitigate the risks of using command-line tools to store
    /// Secrets Manager
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security_cli-exposure-risks.html).
    pub fn updateSecret(self: *Self, input: update_secret.UpdateSecretInput, options: update_secret.Options) !update_secret.UpdateSecretOutput {
        return update_secret.execute(self, input, options);
    }

    /// Modifies the staging labels attached to a version of a secret. Secrets
    /// Manager uses staging
    /// labels to track a version as it progresses through the secret rotation
    /// process. Each
    /// staging label can be attached to only one version at a time. To add a
    /// staging label to a
    /// version when it is already attached to another version, Secrets Manager
    /// first removes it from the
    /// other version first and then attaches it to this one. For more information
    /// about
    /// versions and staging labels, see [Concepts:
    /// Version](https://docs.aws.amazon.com/secretsmanager/latest/userguide/getting-started.html#term_version).
    ///
    /// The staging labels that you specify in the `VersionStage` parameter are
    /// added to the existing list of staging labels for the version.
    ///
    /// You can move the `AWSCURRENT` staging label to this version by including it
    /// in this call.
    ///
    /// **Note:**
    ///
    /// Whenever you move `AWSCURRENT`, Secrets Manager automatically moves the
    /// label
    /// `AWSPREVIOUS` to the version that `AWSCURRENT` was removed
    /// from.
    ///
    /// If this action results in the last label being removed from a version, then
    /// the
    /// version is considered to be 'deprecated' and can be deleted by Secrets
    /// Manager.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:UpdateSecretVersionStage`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn updateSecretVersionStage(self: *Self, input: update_secret_version_stage.UpdateSecretVersionStageInput, options: update_secret_version_stage.Options) !update_secret_version_stage.UpdateSecretVersionStageOutput {
        return update_secret_version_stage.execute(self, input, options);
    }

    /// Validates that a resource policy does not grant a wide range of principals
    /// access to
    /// your secret. A resource-based policy is optional for secrets.
    ///
    /// The API performs three checks when validating the policy:
    ///
    /// * Sends a call to
    ///   [Zelkova](https://aws.amazon.com/blogs/security/protect-sensitive-data-in-the-cloud-with-automated-reasoning-zelkova/), an automated reasoning engine, to ensure your resource
    /// policy does not allow broad access to your secret, for example policies that
    /// use
    /// a wildcard for the principal.
    ///
    /// * Checks for correct syntax in a policy.
    ///
    /// * Verifies the policy does not lock out a caller.
    ///
    /// Secrets Manager generates a CloudTrail log entry when you call this action.
    /// Do not include sensitive information in request parameters because it might
    /// be logged. For more information, see [Logging Secrets Manager events with
    /// CloudTrail](https://docs.aws.amazon.com/secretsmanager/latest/userguide/retrieve-ct-entries.html).
    ///
    /// **Required permissions:
    /// **
    /// `secretsmanager:ValidateResourcePolicy` and
    /// `secretsmanager:PutResourcePolicy`. For more information, see [
    /// IAM policy actions for Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_iam-permissions.html#reference_iam-permissions_actions) and [Authentication
    /// and access control in Secrets
    /// Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access.html).
    pub fn validateResourcePolicy(self: *Self, input: validate_resource_policy.ValidateResourcePolicyInput, options: validate_resource_policy.Options) !validate_resource_policy.ValidateResourcePolicyOutput {
        return validate_resource_policy.execute(self, input, options);
    }

    pub fn batchGetSecretValuePaginator(self: *Self, params: batch_get_secret_value.BatchGetSecretValueInput) paginator.BatchGetSecretValuePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecretVersionIdsPaginator(self: *Self, params: list_secret_version_ids.ListSecretVersionIdsInput) paginator.ListSecretVersionIdsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecretsPaginator(self: *Self, params: list_secrets.ListSecretsInput) paginator.ListSecretsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
