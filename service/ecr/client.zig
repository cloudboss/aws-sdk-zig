const aws = @import("aws");
const std = @import("std");

const batch_check_layer_availability = @import("batch_check_layer_availability.zig");
const batch_delete_image = @import("batch_delete_image.zig");
const batch_get_image = @import("batch_get_image.zig");
const batch_get_repository_scanning_configuration = @import("batch_get_repository_scanning_configuration.zig");
const complete_layer_upload = @import("complete_layer_upload.zig");
const create_pull_through_cache_rule = @import("create_pull_through_cache_rule.zig");
const create_repository = @import("create_repository.zig");
const create_repository_creation_template = @import("create_repository_creation_template.zig");
const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
const delete_pull_through_cache_rule = @import("delete_pull_through_cache_rule.zig");
const delete_registry_policy = @import("delete_registry_policy.zig");
const delete_repository = @import("delete_repository.zig");
const delete_repository_creation_template = @import("delete_repository_creation_template.zig");
const delete_repository_policy = @import("delete_repository_policy.zig");
const delete_signing_configuration = @import("delete_signing_configuration.zig");
const deregister_pull_time_update_exclusion = @import("deregister_pull_time_update_exclusion.zig");
const describe_image_replication_status = @import("describe_image_replication_status.zig");
const describe_image_scan_findings = @import("describe_image_scan_findings.zig");
const describe_image_signing_status = @import("describe_image_signing_status.zig");
const describe_images = @import("describe_images.zig");
const describe_pull_through_cache_rules = @import("describe_pull_through_cache_rules.zig");
const describe_registry = @import("describe_registry.zig");
const describe_repositories = @import("describe_repositories.zig");
const describe_repository_creation_templates = @import("describe_repository_creation_templates.zig");
const get_account_setting = @import("get_account_setting.zig");
const get_authorization_token = @import("get_authorization_token.zig");
const get_download_url_for_layer = @import("get_download_url_for_layer.zig");
const get_lifecycle_policy = @import("get_lifecycle_policy.zig");
const get_lifecycle_policy_preview = @import("get_lifecycle_policy_preview.zig");
const get_registry_policy = @import("get_registry_policy.zig");
const get_registry_scanning_configuration = @import("get_registry_scanning_configuration.zig");
const get_repository_policy = @import("get_repository_policy.zig");
const get_signing_configuration = @import("get_signing_configuration.zig");
const initiate_layer_upload = @import("initiate_layer_upload.zig");
const list_image_referrers = @import("list_image_referrers.zig");
const list_images = @import("list_images.zig");
const list_pull_time_update_exclusions = @import("list_pull_time_update_exclusions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_account_setting = @import("put_account_setting.zig");
const put_image = @import("put_image.zig");
const put_image_scanning_configuration = @import("put_image_scanning_configuration.zig");
const put_image_tag_mutability = @import("put_image_tag_mutability.zig");
const put_lifecycle_policy = @import("put_lifecycle_policy.zig");
const put_registry_policy = @import("put_registry_policy.zig");
const put_registry_scanning_configuration = @import("put_registry_scanning_configuration.zig");
const put_replication_configuration = @import("put_replication_configuration.zig");
const put_signing_configuration = @import("put_signing_configuration.zig");
const register_pull_time_update_exclusion = @import("register_pull_time_update_exclusion.zig");
const set_repository_policy = @import("set_repository_policy.zig");
const start_image_scan = @import("start_image_scan.zig");
const start_lifecycle_policy_preview = @import("start_lifecycle_policy_preview.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_image_storage_class = @import("update_image_storage_class.zig");
const update_pull_through_cache_rule = @import("update_pull_through_cache_rule.zig");
const update_repository_creation_template = @import("update_repository_creation_template.zig");
const upload_layer_part = @import("upload_layer_part.zig");
const validate_pull_through_cache_rule = @import("validate_pull_through_cache_rule.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ECR";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Checks the availability of one or more image layers in a repository.
    ///
    /// When an image is pushed to a repository, each image layer is checked to
    /// verify if it
    /// has been uploaded before. If it has been uploaded, then the image layer is
    /// skipped.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn batchCheckLayerAvailability(self: *Self, allocator: std.mem.Allocator, input: batch_check_layer_availability.BatchCheckLayerAvailabilityInput, options: batch_check_layer_availability.Options) !batch_check_layer_availability.BatchCheckLayerAvailabilityOutput {
        return batch_check_layer_availability.execute(self, allocator, input, options);
    }

    /// Deletes a list of specified images within a repository. Images are specified
    /// with
    /// either an `imageTag` or `imageDigest`.
    ///
    /// You can remove a tag from an image by specifying the image's tag in your
    /// request. When
    /// you remove the last tag from an image, the image is deleted from your
    /// repository.
    ///
    /// You can completely delete an image (and all of its tags) by specifying the
    /// image's
    /// digest in your request.
    pub fn batchDeleteImage(self: *Self, allocator: std.mem.Allocator, input: batch_delete_image.BatchDeleteImageInput, options: batch_delete_image.Options) !batch_delete_image.BatchDeleteImageOutput {
        return batch_delete_image.execute(self, allocator, input, options);
    }

    /// Gets detailed information for an image. Images are specified with either an
    /// `imageTag` or `imageDigest`.
    ///
    /// When an image is pulled, the BatchGetImage API is called once to retrieve
    /// the image
    /// manifest.
    pub fn batchGetImage(self: *Self, allocator: std.mem.Allocator, input: batch_get_image.BatchGetImageInput, options: batch_get_image.Options) !batch_get_image.BatchGetImageOutput {
        return batch_get_image.execute(self, allocator, input, options);
    }

    /// Gets the scanning configuration for one or more repositories.
    pub fn batchGetRepositoryScanningConfiguration(self: *Self, allocator: std.mem.Allocator, input: batch_get_repository_scanning_configuration.BatchGetRepositoryScanningConfigurationInput, options: batch_get_repository_scanning_configuration.Options) !batch_get_repository_scanning_configuration.BatchGetRepositoryScanningConfigurationOutput {
        return batch_get_repository_scanning_configuration.execute(self, allocator, input, options);
    }

    /// Informs Amazon ECR that the image layer upload has completed for a specified
    /// registry,
    /// repository name, and upload ID. You can optionally provide a `sha256` digest
    /// of the image layer for data validation purposes.
    ///
    /// When an image is pushed, the CompleteLayerUpload API is called once per each
    /// new image
    /// layer to verify that the upload has completed.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn completeLayerUpload(self: *Self, allocator: std.mem.Allocator, input: complete_layer_upload.CompleteLayerUploadInput, options: complete_layer_upload.Options) !complete_layer_upload.CompleteLayerUploadOutput {
        return complete_layer_upload.execute(self, allocator, input, options);
    }

    /// Creates a pull through cache rule. A pull through cache rule provides a way
    /// to cache
    /// images from an upstream registry source in your Amazon ECR private registry.
    /// For more
    /// information, see [Using pull through cache
    /// rules](https://docs.aws.amazon.com/AmazonECR/latest/userguide/pull-through-cache.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn createPullThroughCacheRule(self: *Self, allocator: std.mem.Allocator, input: create_pull_through_cache_rule.CreatePullThroughCacheRuleInput, options: create_pull_through_cache_rule.Options) !create_pull_through_cache_rule.CreatePullThroughCacheRuleOutput {
        return create_pull_through_cache_rule.execute(self, allocator, input, options);
    }

    /// Creates a repository. For more information, see [Amazon ECR
    /// repositories](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Repositories.html) in the
    /// *Amazon Elastic Container Registry User Guide*.
    pub fn createRepository(self: *Self, allocator: std.mem.Allocator, input: create_repository.CreateRepositoryInput, options: create_repository.Options) !create_repository.CreateRepositoryOutput {
        return create_repository.execute(self, allocator, input, options);
    }

    /// Creates a repository creation template. This template is used to define the
    /// settings
    /// for repositories created by Amazon ECR on your behalf. For example,
    /// repositories created
    /// through pull through cache actions. For more information, see [Private
    /// repository creation
    /// templates](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-creation-templates.html) in the
    /// *Amazon Elastic Container Registry User Guide*.
    pub fn createRepositoryCreationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_repository_creation_template.CreateRepositoryCreationTemplateInput, options: create_repository_creation_template.Options) !create_repository_creation_template.CreateRepositoryCreationTemplateOutput {
        return create_repository_creation_template.execute(self, allocator, input, options);
    }

    /// Deletes the lifecycle policy associated with the specified repository.
    pub fn deleteLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_policy.DeleteLifecyclePolicyInput, options: delete_lifecycle_policy.Options) !delete_lifecycle_policy.DeleteLifecyclePolicyOutput {
        return delete_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Deletes a pull through cache rule.
    pub fn deletePullThroughCacheRule(self: *Self, allocator: std.mem.Allocator, input: delete_pull_through_cache_rule.DeletePullThroughCacheRuleInput, options: delete_pull_through_cache_rule.Options) !delete_pull_through_cache_rule.DeletePullThroughCacheRuleOutput {
        return delete_pull_through_cache_rule.execute(self, allocator, input, options);
    }

    /// Deletes the registry permissions policy.
    pub fn deleteRegistryPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_registry_policy.DeleteRegistryPolicyInput, options: delete_registry_policy.Options) !delete_registry_policy.DeleteRegistryPolicyOutput {
        return delete_registry_policy.execute(self, allocator, input, options);
    }

    /// Deletes a repository. If the repository isn't empty, you must either delete
    /// the
    /// contents of the repository or use the `force` option to delete the
    /// repository
    /// and have Amazon ECR delete all of its contents on your behalf.
    pub fn deleteRepository(self: *Self, allocator: std.mem.Allocator, input: delete_repository.DeleteRepositoryInput, options: delete_repository.Options) !delete_repository.DeleteRepositoryOutput {
        return delete_repository.execute(self, allocator, input, options);
    }

    /// Deletes a repository creation template.
    pub fn deleteRepositoryCreationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_repository_creation_template.DeleteRepositoryCreationTemplateInput, options: delete_repository_creation_template.Options) !delete_repository_creation_template.DeleteRepositoryCreationTemplateOutput {
        return delete_repository_creation_template.execute(self, allocator, input, options);
    }

    /// Deletes the repository policy associated with the specified repository.
    pub fn deleteRepositoryPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_repository_policy.DeleteRepositoryPolicyInput, options: delete_repository_policy.Options) !delete_repository_policy.DeleteRepositoryPolicyOutput {
        return delete_repository_policy.execute(self, allocator, input, options);
    }

    /// Deletes the registry's signing configuration. Images pushed after deletion
    /// of the signing
    /// configuration will no longer be automatically signed.
    ///
    /// For more information, see [Managed
    /// signing](https://docs.aws.amazon.com/AmazonECR/latest/userguide/managed-signing.html) in the
    /// *Amazon Elastic Container Registry User Guide*.
    ///
    /// Deleting the signing configuration does not affect existing image
    /// signatures.
    pub fn deleteSigningConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_signing_configuration.DeleteSigningConfigurationInput, options: delete_signing_configuration.Options) !delete_signing_configuration.DeleteSigningConfigurationOutput {
        return delete_signing_configuration.execute(self, allocator, input, options);
    }

    /// Removes a principal from the pull time update exclusion list for a registry.
    /// Once removed, Amazon ECR will resume updating the pull time if the specified
    /// principal pulls an image.
    pub fn deregisterPullTimeUpdateExclusion(self: *Self, allocator: std.mem.Allocator, input: deregister_pull_time_update_exclusion.DeregisterPullTimeUpdateExclusionInput, options: deregister_pull_time_update_exclusion.Options) !deregister_pull_time_update_exclusion.DeregisterPullTimeUpdateExclusionOutput {
        return deregister_pull_time_update_exclusion.execute(self, allocator, input, options);
    }

    /// Returns the replication status for a specified image.
    pub fn describeImageReplicationStatus(self: *Self, allocator: std.mem.Allocator, input: describe_image_replication_status.DescribeImageReplicationStatusInput, options: describe_image_replication_status.Options) !describe_image_replication_status.DescribeImageReplicationStatusOutput {
        return describe_image_replication_status.execute(self, allocator, input, options);
    }

    /// Returns the scan findings for the specified image.
    pub fn describeImageScanFindings(self: *Self, allocator: std.mem.Allocator, input: describe_image_scan_findings.DescribeImageScanFindingsInput, options: describe_image_scan_findings.Options) !describe_image_scan_findings.DescribeImageScanFindingsOutput {
        return describe_image_scan_findings.execute(self, allocator, input, options);
    }

    /// Returns the signing status for a specified image. If the image matched
    /// signing rules that reference different signing profiles, a status is
    /// returned
    /// for each profile.
    ///
    /// For more information, see [Managed
    /// signing](https://docs.aws.amazon.com/AmazonECR/latest/userguide/managed-signing.html) in the
    /// *Amazon Elastic Container Registry User Guide*.
    pub fn describeImageSigningStatus(self: *Self, allocator: std.mem.Allocator, input: describe_image_signing_status.DescribeImageSigningStatusInput, options: describe_image_signing_status.Options) !describe_image_signing_status.DescribeImageSigningStatusOutput {
        return describe_image_signing_status.execute(self, allocator, input, options);
    }

    /// Returns metadata about the images in a repository.
    ///
    /// Starting with Docker version 1.9, the Docker client compresses image layers
    /// before
    /// pushing them to a V2 Docker registry. The output of the `docker images`
    /// command shows the uncompressed image size. Therefore, Docker might return a
    /// larger
    /// image than the image shown in the Amazon Web Services Management Console.
    ///
    /// The new version of Amazon ECR
    /// *Basic Scanning* doesn't use the ImageDetail$imageScanFindingsSummary and
    /// ImageDetail$imageScanStatus attributes from the API response to
    /// return scan results. Use the DescribeImageScanFindings API
    /// instead. For more information about Amazon Web Services native basic
    /// scanning, see [ Scan
    /// images for software vulnerabilities in Amazon
    /// ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html).
    pub fn describeImages(self: *Self, allocator: std.mem.Allocator, input: describe_images.DescribeImagesInput, options: describe_images.Options) !describe_images.DescribeImagesOutput {
        return describe_images.execute(self, allocator, input, options);
    }

    /// Returns the pull through cache rules for a registry.
    pub fn describePullThroughCacheRules(self: *Self, allocator: std.mem.Allocator, input: describe_pull_through_cache_rules.DescribePullThroughCacheRulesInput, options: describe_pull_through_cache_rules.Options) !describe_pull_through_cache_rules.DescribePullThroughCacheRulesOutput {
        return describe_pull_through_cache_rules.execute(self, allocator, input, options);
    }

    /// Describes the settings for a registry. The replication configuration for a
    /// repository
    /// can be created or updated with the PutReplicationConfiguration API
    /// action.
    pub fn describeRegistry(self: *Self, allocator: std.mem.Allocator, input: describe_registry.DescribeRegistryInput, options: describe_registry.Options) !describe_registry.DescribeRegistryOutput {
        return describe_registry.execute(self, allocator, input, options);
    }

    /// Describes image repositories in a registry.
    pub fn describeRepositories(self: *Self, allocator: std.mem.Allocator, input: describe_repositories.DescribeRepositoriesInput, options: describe_repositories.Options) !describe_repositories.DescribeRepositoriesOutput {
        return describe_repositories.execute(self, allocator, input, options);
    }

    /// Returns details about the repository creation templates in a registry. The
    /// `prefixes` request parameter can be used to return the details for a
    /// specific repository creation template.
    pub fn describeRepositoryCreationTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_repository_creation_templates.DescribeRepositoryCreationTemplatesInput, options: describe_repository_creation_templates.Options) !describe_repository_creation_templates.DescribeRepositoryCreationTemplatesOutput {
        return describe_repository_creation_templates.execute(self, allocator, input, options);
    }

    /// Retrieves the account setting value for the specified setting name.
    pub fn getAccountSetting(self: *Self, allocator: std.mem.Allocator, input: get_account_setting.GetAccountSettingInput, options: get_account_setting.Options) !get_account_setting.GetAccountSettingOutput {
        return get_account_setting.execute(self, allocator, input, options);
    }

    /// Retrieves an authorization token. An authorization token represents your IAM
    /// authentication credentials and can be used to access any Amazon ECR registry
    /// that your IAM
    /// principal has access to. The authorization token is valid for 12 hours.
    ///
    /// The `authorizationToken` returned is a base64 encoded string that can be
    /// decoded and used in a `docker login` command to authenticate to a registry.
    /// The CLI offers an `get-login-password` command that simplifies the login
    /// process. For more information, see [Registry
    /// authentication](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html#registry_auth) in the *Amazon Elastic Container Registry User Guide*.
    pub fn getAuthorizationToken(self: *Self, allocator: std.mem.Allocator, input: get_authorization_token.GetAuthorizationTokenInput, options: get_authorization_token.Options) !get_authorization_token.GetAuthorizationTokenOutput {
        return get_authorization_token.execute(self, allocator, input, options);
    }

    /// Retrieves the pre-signed Amazon S3 download URL corresponding to an image
    /// layer. You can
    /// only get URLs for image layers that are referenced in an image.
    ///
    /// When an image is pulled, the GetDownloadUrlForLayer API is called once per
    /// image layer
    /// that is not already cached.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn getDownloadUrlForLayer(self: *Self, allocator: std.mem.Allocator, input: get_download_url_for_layer.GetDownloadUrlForLayerInput, options: get_download_url_for_layer.Options) !get_download_url_for_layer.GetDownloadUrlForLayerOutput {
        return get_download_url_for_layer.execute(self, allocator, input, options);
    }

    /// Retrieves the lifecycle policy for the specified repository.
    pub fn getLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policy.GetLifecyclePolicyInput, options: get_lifecycle_policy.Options) !get_lifecycle_policy.GetLifecyclePolicyOutput {
        return get_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the results of the lifecycle policy preview request for the
    /// specified
    /// repository.
    pub fn getLifecyclePolicyPreview(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policy_preview.GetLifecyclePolicyPreviewInput, options: get_lifecycle_policy_preview.Options) !get_lifecycle_policy_preview.GetLifecyclePolicyPreviewOutput {
        return get_lifecycle_policy_preview.execute(self, allocator, input, options);
    }

    /// Retrieves the permissions policy for a registry.
    pub fn getRegistryPolicy(self: *Self, allocator: std.mem.Allocator, input: get_registry_policy.GetRegistryPolicyInput, options: get_registry_policy.Options) !get_registry_policy.GetRegistryPolicyOutput {
        return get_registry_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the scanning configuration for a registry.
    pub fn getRegistryScanningConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_registry_scanning_configuration.GetRegistryScanningConfigurationInput, options: get_registry_scanning_configuration.Options) !get_registry_scanning_configuration.GetRegistryScanningConfigurationOutput {
        return get_registry_scanning_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the repository policy for the specified repository.
    pub fn getRepositoryPolicy(self: *Self, allocator: std.mem.Allocator, input: get_repository_policy.GetRepositoryPolicyInput, options: get_repository_policy.Options) !get_repository_policy.GetRepositoryPolicyOutput {
        return get_repository_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the registry's signing configuration, which defines
    /// rules for automatically signing images using Amazon Web Services Signer.
    ///
    /// For more information, see [Managed
    /// signing](https://docs.aws.amazon.com/AmazonECR/latest/userguide/managed-signing.html) in the
    /// *Amazon Elastic Container Registry User Guide*.
    pub fn getSigningConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_signing_configuration.GetSigningConfigurationInput, options: get_signing_configuration.Options) !get_signing_configuration.GetSigningConfigurationOutput {
        return get_signing_configuration.execute(self, allocator, input, options);
    }

    /// Notifies Amazon ECR that you intend to upload an image layer.
    ///
    /// When an image is pushed, the InitiateLayerUpload API is called once per
    /// image layer
    /// that has not already been uploaded. Whether or not an image layer has been
    /// uploaded is
    /// determined by the BatchCheckLayerAvailability API action.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn initiateLayerUpload(self: *Self, allocator: std.mem.Allocator, input: initiate_layer_upload.InitiateLayerUploadInput, options: initiate_layer_upload.Options) !initiate_layer_upload.InitiateLayerUploadOutput {
        return initiate_layer_upload.execute(self, allocator, input, options);
    }

    /// Lists the artifacts associated with a specified subject image.
    pub fn listImageReferrers(self: *Self, allocator: std.mem.Allocator, input: list_image_referrers.ListImageReferrersInput, options: list_image_referrers.Options) !list_image_referrers.ListImageReferrersOutput {
        return list_image_referrers.execute(self, allocator, input, options);
    }

    /// Lists all the image IDs for the specified repository.
    ///
    /// You can filter images based on whether or not they are tagged by using the
    /// `tagStatus` filter and specifying either `TAGGED`,
    /// `UNTAGGED` or `ANY`. For example, you can filter your results
    /// to return only `UNTAGGED` images and then pipe that result to a
    /// BatchDeleteImage operation to delete them. Or, you can filter your
    /// results to return only `TAGGED` images to list all of the tags in your
    /// repository.
    pub fn listImages(self: *Self, allocator: std.mem.Allocator, input: list_images.ListImagesInput, options: list_images.Options) !list_images.ListImagesOutput {
        return list_images.execute(self, allocator, input, options);
    }

    /// Lists the IAM principals that are excluded from having their image pull
    /// times recorded.
    pub fn listPullTimeUpdateExclusions(self: *Self, allocator: std.mem.Allocator, input: list_pull_time_update_exclusions.ListPullTimeUpdateExclusionsInput, options: list_pull_time_update_exclusions.Options) !list_pull_time_update_exclusions.ListPullTimeUpdateExclusionsOutput {
        return list_pull_time_update_exclusions.execute(self, allocator, input, options);
    }

    /// List the tags for an Amazon ECR resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Allows you to change the basic scan type version or registry policy scope.
    pub fn putAccountSetting(self: *Self, allocator: std.mem.Allocator, input: put_account_setting.PutAccountSettingInput, options: put_account_setting.Options) !put_account_setting.PutAccountSettingOutput {
        return put_account_setting.execute(self, allocator, input, options);
    }

    /// Creates or updates the image manifest and tags associated with an image.
    ///
    /// When an image is pushed and all new image layers have been uploaded, the
    /// PutImage API
    /// is called once to create or update the image manifest and the tags
    /// associated with the
    /// image.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn putImage(self: *Self, allocator: std.mem.Allocator, input: put_image.PutImageInput, options: put_image.Options) !put_image.PutImageOutput {
        return put_image.execute(self, allocator, input, options);
    }

    /// The `PutImageScanningConfiguration` API is being deprecated, in favor
    /// of specifying the image scanning configuration at the registry level. For
    /// more
    /// information, see PutRegistryScanningConfiguration.
    ///
    /// Updates the image scanning configuration for the specified repository.
    pub fn putImageScanningConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_image_scanning_configuration.PutImageScanningConfigurationInput, options: put_image_scanning_configuration.Options) !put_image_scanning_configuration.PutImageScanningConfigurationOutput {
        return put_image_scanning_configuration.execute(self, allocator, input, options);
    }

    /// Updates the image tag mutability settings for the specified repository. For
    /// more
    /// information, see [Image tag
    /// mutability](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-tag-mutability.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn putImageTagMutability(self: *Self, allocator: std.mem.Allocator, input: put_image_tag_mutability.PutImageTagMutabilityInput, options: put_image_tag_mutability.Options) !put_image_tag_mutability.PutImageTagMutabilityOutput {
        return put_image_tag_mutability.execute(self, allocator, input, options);
    }

    /// Creates or updates the lifecycle policy for the specified repository. For
    /// more
    /// information, see [Lifecycle policy
    /// template](https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html).
    pub fn putLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: put_lifecycle_policy.PutLifecyclePolicyInput, options: put_lifecycle_policy.Options) !put_lifecycle_policy.PutLifecyclePolicyOutput {
        return put_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates the permissions policy for your registry.
    ///
    /// A registry policy is used to specify permissions for another Amazon Web
    /// Services account and is used
    /// when configuring cross-account replication. For more information, see
    /// [Registry
    /// permissions](https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry-permissions.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn putRegistryPolicy(self: *Self, allocator: std.mem.Allocator, input: put_registry_policy.PutRegistryPolicyInput, options: put_registry_policy.Options) !put_registry_policy.PutRegistryPolicyOutput {
        return put_registry_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates the scanning configuration for your private registry.
    pub fn putRegistryScanningConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_registry_scanning_configuration.PutRegistryScanningConfigurationInput, options: put_registry_scanning_configuration.Options) !put_registry_scanning_configuration.PutRegistryScanningConfigurationOutput {
        return put_registry_scanning_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates the replication configuration for a registry. The
    /// existing
    /// replication configuration for a repository can be retrieved with the
    /// DescribeRegistry API action. The first time the
    /// PutReplicationConfiguration API is called, a service-linked IAM role is
    /// created in
    /// your account for the replication process. For more information, see [Using
    /// service-linked roles for Amazon
    /// ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/using-service-linked-roles.html) in the *Amazon Elastic Container Registry User Guide*.
    /// For more information on the custom role for replication, see [Creating an
    /// IAM role for
    /// replication](https://docs.aws.amazon.com/AmazonECR/latest/userguide/replication-creation-templates.html#roles-creatingrole-user-console).
    ///
    /// When configuring cross-account replication, the destination account must
    /// grant the
    /// source account permission to replicate. This permission is controlled using
    /// a
    /// registry permissions policy. For more information, see PutRegistryPolicy.
    pub fn putReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_replication_configuration.PutReplicationConfigurationInput, options: put_replication_configuration.Options) !put_replication_configuration.PutReplicationConfigurationOutput {
        return put_replication_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates the registry's signing configuration, which defines
    /// rules for automatically signing images with Amazon Web Services Signer.
    ///
    /// For more information, see [Managed
    /// signing](https://docs.aws.amazon.com/AmazonECR/latest/userguide/managed-signing.html) in the
    /// *Amazon Elastic Container Registry User Guide*.
    ///
    /// To successfully generate a signature, the IAM principal pushing images must
    /// have
    /// permission to sign payloads with the Amazon Web Services Signer signing
    /// profile referenced in the signing
    /// configuration.
    pub fn putSigningConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_signing_configuration.PutSigningConfigurationInput, options: put_signing_configuration.Options) !put_signing_configuration.PutSigningConfigurationOutput {
        return put_signing_configuration.execute(self, allocator, input, options);
    }

    /// Adds an IAM principal to the pull time update exclusion list for a registry.
    /// Amazon ECR will not record the pull time if an excluded principal pulls an
    /// image.
    pub fn registerPullTimeUpdateExclusion(self: *Self, allocator: std.mem.Allocator, input: register_pull_time_update_exclusion.RegisterPullTimeUpdateExclusionInput, options: register_pull_time_update_exclusion.Options) !register_pull_time_update_exclusion.RegisterPullTimeUpdateExclusionOutput {
        return register_pull_time_update_exclusion.execute(self, allocator, input, options);
    }

    /// Applies a repository policy to the specified repository to control access
    /// permissions.
    /// For more information, see [Amazon ECR Repository
    /// policies](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-policies.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn setRepositoryPolicy(self: *Self, allocator: std.mem.Allocator, input: set_repository_policy.SetRepositoryPolicyInput, options: set_repository_policy.Options) !set_repository_policy.SetRepositoryPolicyOutput {
        return set_repository_policy.execute(self, allocator, input, options);
    }

    /// Starts a basic image vulnerability scan.
    ///
    /// A basic image scan can only be started once per 24 hours on an individual
    /// image. This
    /// limit includes if an image was scanned on initial push. You can start up to
    /// 100,000
    /// basic scans per 24 hours. This limit includes both scans on initial push and
    /// scans
    /// initiated by the StartImageScan API. For more information, see [Basic
    /// scanning](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning-basic.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn startImageScan(self: *Self, allocator: std.mem.Allocator, input: start_image_scan.StartImageScanInput, options: start_image_scan.Options) !start_image_scan.StartImageScanOutput {
        return start_image_scan.execute(self, allocator, input, options);
    }

    /// Starts a preview of a lifecycle policy for the specified repository. This
    /// allows you
    /// to see the results before associating the lifecycle policy with the
    /// repository.
    pub fn startLifecyclePolicyPreview(self: *Self, allocator: std.mem.Allocator, input: start_lifecycle_policy_preview.StartLifecyclePolicyPreviewInput, options: start_lifecycle_policy_preview.Options) !start_lifecycle_policy_preview.StartLifecyclePolicyPreviewOutput {
        return start_lifecycle_policy_preview.execute(self, allocator, input, options);
    }

    /// Adds specified tags to a resource with the specified ARN. Existing tags on a
    /// resource
    /// are not changed if they are not specified in the request parameters.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Transitions an image between storage classes. You can transition images from
    /// Amazon ECR standard storage class to Amazon ECR archival storage class for
    /// long-term storage, or restore archived images back to Amazon ECR standard.
    pub fn updateImageStorageClass(self: *Self, allocator: std.mem.Allocator, input: update_image_storage_class.UpdateImageStorageClassInput, options: update_image_storage_class.Options) !update_image_storage_class.UpdateImageStorageClassOutput {
        return update_image_storage_class.execute(self, allocator, input, options);
    }

    /// Updates an existing pull through cache rule.
    pub fn updatePullThroughCacheRule(self: *Self, allocator: std.mem.Allocator, input: update_pull_through_cache_rule.UpdatePullThroughCacheRuleInput, options: update_pull_through_cache_rule.Options) !update_pull_through_cache_rule.UpdatePullThroughCacheRuleOutput {
        return update_pull_through_cache_rule.execute(self, allocator, input, options);
    }

    /// Updates an existing repository creation template.
    pub fn updateRepositoryCreationTemplate(self: *Self, allocator: std.mem.Allocator, input: update_repository_creation_template.UpdateRepositoryCreationTemplateInput, options: update_repository_creation_template.Options) !update_repository_creation_template.UpdateRepositoryCreationTemplateOutput {
        return update_repository_creation_template.execute(self, allocator, input, options);
    }

    /// Uploads an image layer part to Amazon ECR.
    ///
    /// When an image is pushed, each new image layer is uploaded in parts. The
    /// maximum size
    /// of each image layer part can be 20971520 bytes (or about 20MB). The
    /// UploadLayerPart API
    /// is called once per each new image layer part.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn uploadLayerPart(self: *Self, allocator: std.mem.Allocator, input: upload_layer_part.UploadLayerPartInput, options: upload_layer_part.Options) !upload_layer_part.UploadLayerPartOutput {
        return upload_layer_part.execute(self, allocator, input, options);
    }

    /// Validates an existing pull through cache rule for an upstream registry that
    /// requires
    /// authentication. This will retrieve the contents of the Amazon Web Services
    /// Secrets Manager secret, verify the
    /// syntax, and then validate that authentication to the upstream registry is
    /// successful.
    pub fn validatePullThroughCacheRule(self: *Self, allocator: std.mem.Allocator, input: validate_pull_through_cache_rule.ValidatePullThroughCacheRuleInput, options: validate_pull_through_cache_rule.Options) !validate_pull_through_cache_rule.ValidatePullThroughCacheRuleOutput {
        return validate_pull_through_cache_rule.execute(self, allocator, input, options);
    }

    pub fn describeImageScanFindingsPaginator(self: *Self, params: describe_image_scan_findings.DescribeImageScanFindingsInput) paginator.DescribeImageScanFindingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImagesPaginator(self: *Self, params: describe_images.DescribeImagesInput) paginator.DescribeImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePullThroughCacheRulesPaginator(self: *Self, params: describe_pull_through_cache_rules.DescribePullThroughCacheRulesInput) paginator.DescribePullThroughCacheRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRepositoriesPaginator(self: *Self, params: describe_repositories.DescribeRepositoriesInput) paginator.DescribeRepositoriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRepositoryCreationTemplatesPaginator(self: *Self, params: describe_repository_creation_templates.DescribeRepositoryCreationTemplatesInput) paginator.DescribeRepositoryCreationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getLifecyclePolicyPreviewPaginator(self: *Self, params: get_lifecycle_policy_preview.GetLifecyclePolicyPreviewInput) paginator.GetLifecyclePolicyPreviewPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagesPaginator(self: *Self, params: list_images.ListImagesInput) paginator.ListImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilImageScanComplete(self: *Self, params: describe_image_scan_findings.DescribeImageScanFindingsInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageScanCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLifecyclePolicyPreviewComplete(self: *Self, params: get_lifecycle_policy_preview.GetLifecyclePolicyPreviewInput) aws.waiter.WaiterError!void {
        var w = waiters.LifecyclePolicyPreviewCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
