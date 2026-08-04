const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        blocked_by_organization_policy_exception: BlockedByOrganizationPolicyException,
        empty_upload_exception: EmptyUploadException,
        exclusion_already_exists_exception: ExclusionAlreadyExistsException,
        exclusion_not_found_exception: ExclusionNotFoundException,
        image_already_exists_exception: ImageAlreadyExistsException,
        image_archived_exception: ImageArchivedException,
        image_digest_does_not_match_exception: ImageDigestDoesNotMatchException,
        image_not_found_exception: ImageNotFoundException,
        image_storage_class_update_not_supported_exception: ImageStorageClassUpdateNotSupportedException,
        image_tag_already_exists_exception: ImageTagAlreadyExistsException,
        invalid_layer_exception: InvalidLayerException,
        invalid_layer_part_exception: InvalidLayerPartException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_tag_parameter_exception: InvalidTagParameterException,
        kms_exception: KmsException,
        layer_already_exists_exception: LayerAlreadyExistsException,
        layer_inaccessible_exception: LayerInaccessibleException,
        layer_part_too_small_exception: LayerPartTooSmallException,
        layers_not_found_exception: LayersNotFoundException,
        lifecycle_policy_not_found_exception: LifecyclePolicyNotFoundException,
        lifecycle_policy_preview_in_progress_exception: LifecyclePolicyPreviewInProgressException,
        lifecycle_policy_preview_not_found_exception: LifecyclePolicyPreviewNotFoundException,
        limit_exceeded_exception: LimitExceededException,
        pull_through_cache_rule_already_exists_exception: PullThroughCacheRuleAlreadyExistsException,
        pull_through_cache_rule_not_found_exception: PullThroughCacheRuleNotFoundException,
        referenced_images_not_found_exception: ReferencedImagesNotFoundException,
        registry_policy_not_found_exception: RegistryPolicyNotFoundException,
        repository_already_exists_exception: RepositoryAlreadyExistsException,
        repository_not_empty_exception: RepositoryNotEmptyException,
        repository_not_found_exception: RepositoryNotFoundException,
        repository_policy_not_found_exception: RepositoryPolicyNotFoundException,
        scan_not_found_exception: ScanNotFoundException,
        secret_not_found_exception: SecretNotFoundException,
        server_exception: ServerException,
        signing_configuration_not_found_exception: SigningConfigurationNotFoundException,
        template_already_exists_exception: TemplateAlreadyExistsException,
        template_not_found_exception: TemplateNotFoundException,
        too_many_tags_exception: TooManyTagsException,
        unable_to_access_secret_exception: UnableToAccessSecretException,
        unable_to_decrypt_secret_value_exception: UnableToDecryptSecretValueException,
        unable_to_get_upstream_image_exception: UnableToGetUpstreamImageException,
        unable_to_get_upstream_layer_exception: UnableToGetUpstreamLayerException,
        unable_to_list_upstream_image_referrers_exception: UnableToListUpstreamImageReferrersException,
        unsupported_image_type_exception: UnsupportedImageTypeException,
        unsupported_upstream_registry_exception: UnsupportedUpstreamRegistryException,
        upload_not_found_exception: UploadNotFoundException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .blocked_by_organization_policy_exception => "BlockedByOrganizationPolicyException",
                .empty_upload_exception => "EmptyUploadException",
                .exclusion_already_exists_exception => "ExclusionAlreadyExistsException",
                .exclusion_not_found_exception => "ExclusionNotFoundException",
                .image_already_exists_exception => "ImageAlreadyExistsException",
                .image_archived_exception => "ImageArchivedException",
                .image_digest_does_not_match_exception => "ImageDigestDoesNotMatchException",
                .image_not_found_exception => "ImageNotFoundException",
                .image_storage_class_update_not_supported_exception => "ImageStorageClassUpdateNotSupportedException",
                .image_tag_already_exists_exception => "ImageTagAlreadyExistsException",
                .invalid_layer_exception => "InvalidLayerException",
                .invalid_layer_part_exception => "InvalidLayerPartException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_tag_parameter_exception => "InvalidTagParameterException",
                .kms_exception => "KmsException",
                .layer_already_exists_exception => "LayerAlreadyExistsException",
                .layer_inaccessible_exception => "LayerInaccessibleException",
                .layer_part_too_small_exception => "LayerPartTooSmallException",
                .layers_not_found_exception => "LayersNotFoundException",
                .lifecycle_policy_not_found_exception => "LifecyclePolicyNotFoundException",
                .lifecycle_policy_preview_in_progress_exception => "LifecyclePolicyPreviewInProgressException",
                .lifecycle_policy_preview_not_found_exception => "LifecyclePolicyPreviewNotFoundException",
                .limit_exceeded_exception => "LimitExceededException",
                .pull_through_cache_rule_already_exists_exception => "PullThroughCacheRuleAlreadyExistsException",
                .pull_through_cache_rule_not_found_exception => "PullThroughCacheRuleNotFoundException",
                .referenced_images_not_found_exception => "ReferencedImagesNotFoundException",
                .registry_policy_not_found_exception => "RegistryPolicyNotFoundException",
                .repository_already_exists_exception => "RepositoryAlreadyExistsException",
                .repository_not_empty_exception => "RepositoryNotEmptyException",
                .repository_not_found_exception => "RepositoryNotFoundException",
                .repository_policy_not_found_exception => "RepositoryPolicyNotFoundException",
                .scan_not_found_exception => "ScanNotFoundException",
                .secret_not_found_exception => "SecretNotFoundException",
                .server_exception => "ServerException",
                .signing_configuration_not_found_exception => "SigningConfigurationNotFoundException",
                .template_already_exists_exception => "TemplateAlreadyExistsException",
                .template_not_found_exception => "TemplateNotFoundException",
                .too_many_tags_exception => "TooManyTagsException",
                .unable_to_access_secret_exception => "UnableToAccessSecretException",
                .unable_to_decrypt_secret_value_exception => "UnableToDecryptSecretValueException",
                .unable_to_get_upstream_image_exception => "UnableToGetUpstreamImageException",
                .unable_to_get_upstream_layer_exception => "UnableToGetUpstreamLayerException",
                .unable_to_list_upstream_image_referrers_exception => "UnableToListUpstreamImageReferrersException",
                .unsupported_image_type_exception => "UnsupportedImageTypeException",
                .unsupported_upstream_registry_exception => "UnsupportedUpstreamRegistryException",
                .upload_not_found_exception => "UploadNotFoundException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .blocked_by_organization_policy_exception => |e| e.message,
                .empty_upload_exception => |e| e.message,
                .exclusion_already_exists_exception => |e| e.message,
                .exclusion_not_found_exception => |e| e.message,
                .image_already_exists_exception => |e| e.message,
                .image_archived_exception => |e| e.message,
                .image_digest_does_not_match_exception => |e| e.message,
                .image_not_found_exception => |e| e.message,
                .image_storage_class_update_not_supported_exception => |e| e.message,
                .image_tag_already_exists_exception => |e| e.message,
                .invalid_layer_exception => |e| e.message,
                .invalid_layer_part_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_tag_parameter_exception => |e| e.message,
                .kms_exception => |e| e.message,
                .layer_already_exists_exception => |e| e.message,
                .layer_inaccessible_exception => |e| e.message,
                .layer_part_too_small_exception => |e| e.message,
                .layers_not_found_exception => |e| e.message,
                .lifecycle_policy_not_found_exception => |e| e.message,
                .lifecycle_policy_preview_in_progress_exception => |e| e.message,
                .lifecycle_policy_preview_not_found_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .pull_through_cache_rule_already_exists_exception => |e| e.message,
                .pull_through_cache_rule_not_found_exception => |e| e.message,
                .referenced_images_not_found_exception => |e| e.message,
                .registry_policy_not_found_exception => |e| e.message,
                .repository_already_exists_exception => |e| e.message,
                .repository_not_empty_exception => |e| e.message,
                .repository_not_found_exception => |e| e.message,
                .repository_policy_not_found_exception => |e| e.message,
                .scan_not_found_exception => |e| e.message,
                .secret_not_found_exception => |e| e.message,
                .server_exception => |e| e.message,
                .signing_configuration_not_found_exception => |e| e.message,
                .template_already_exists_exception => |e| e.message,
                .template_not_found_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unable_to_access_secret_exception => |e| e.message,
                .unable_to_decrypt_secret_value_exception => |e| e.message,
                .unable_to_get_upstream_image_exception => |e| e.message,
                .unable_to_get_upstream_layer_exception => |e| e.message,
                .unable_to_list_upstream_image_referrers_exception => |e| e.message,
                .unsupported_image_type_exception => |e| e.message,
                .unsupported_upstream_registry_exception => |e| e.message,
                .upload_not_found_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .blocked_by_organization_policy_exception => 400,
                .empty_upload_exception => 400,
                .exclusion_already_exists_exception => 400,
                .exclusion_not_found_exception => 400,
                .image_already_exists_exception => 400,
                .image_archived_exception => 400,
                .image_digest_does_not_match_exception => 400,
                .image_not_found_exception => 400,
                .image_storage_class_update_not_supported_exception => 400,
                .image_tag_already_exists_exception => 400,
                .invalid_layer_exception => 400,
                .invalid_layer_part_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_tag_parameter_exception => 400,
                .kms_exception => 400,
                .layer_already_exists_exception => 400,
                .layer_inaccessible_exception => 400,
                .layer_part_too_small_exception => 400,
                .layers_not_found_exception => 400,
                .lifecycle_policy_not_found_exception => 400,
                .lifecycle_policy_preview_in_progress_exception => 400,
                .lifecycle_policy_preview_not_found_exception => 400,
                .limit_exceeded_exception => 400,
                .pull_through_cache_rule_already_exists_exception => 400,
                .pull_through_cache_rule_not_found_exception => 400,
                .referenced_images_not_found_exception => 400,
                .registry_policy_not_found_exception => 400,
                .repository_already_exists_exception => 400,
                .repository_not_empty_exception => 400,
                .repository_not_found_exception => 400,
                .repository_policy_not_found_exception => 400,
                .scan_not_found_exception => 400,
                .secret_not_found_exception => 400,
                .server_exception => 500,
                .signing_configuration_not_found_exception => 400,
                .template_already_exists_exception => 400,
                .template_not_found_exception => 400,
                .too_many_tags_exception => 400,
                .unable_to_access_secret_exception => 400,
                .unable_to_decrypt_secret_value_exception => 400,
                .unable_to_get_upstream_image_exception => 400,
                .unable_to_get_upstream_layer_exception => 400,
                .unable_to_list_upstream_image_referrers_exception => 400,
                .unsupported_image_type_exception => 400,
                .unsupported_upstream_registry_exception => 400,
                .upload_not_found_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .blocked_by_organization_policy_exception => |e| e.request_id,
                .empty_upload_exception => |e| e.request_id,
                .exclusion_already_exists_exception => |e| e.request_id,
                .exclusion_not_found_exception => |e| e.request_id,
                .image_already_exists_exception => |e| e.request_id,
                .image_archived_exception => |e| e.request_id,
                .image_digest_does_not_match_exception => |e| e.request_id,
                .image_not_found_exception => |e| e.request_id,
                .image_storage_class_update_not_supported_exception => |e| e.request_id,
                .image_tag_already_exists_exception => |e| e.request_id,
                .invalid_layer_exception => |e| e.request_id,
                .invalid_layer_part_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_tag_parameter_exception => |e| e.request_id,
                .kms_exception => |e| e.request_id,
                .layer_already_exists_exception => |e| e.request_id,
                .layer_inaccessible_exception => |e| e.request_id,
                .layer_part_too_small_exception => |e| e.request_id,
                .layers_not_found_exception => |e| e.request_id,
                .lifecycle_policy_not_found_exception => |e| e.request_id,
                .lifecycle_policy_preview_in_progress_exception => |e| e.request_id,
                .lifecycle_policy_preview_not_found_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .pull_through_cache_rule_already_exists_exception => |e| e.request_id,
                .pull_through_cache_rule_not_found_exception => |e| e.request_id,
                .referenced_images_not_found_exception => |e| e.request_id,
                .registry_policy_not_found_exception => |e| e.request_id,
                .repository_already_exists_exception => |e| e.request_id,
                .repository_not_empty_exception => |e| e.request_id,
                .repository_not_found_exception => |e| e.request_id,
                .repository_policy_not_found_exception => |e| e.request_id,
                .scan_not_found_exception => |e| e.request_id,
                .secret_not_found_exception => |e| e.request_id,
                .server_exception => |e| e.request_id,
                .signing_configuration_not_found_exception => |e| e.request_id,
                .template_already_exists_exception => |e| e.request_id,
                .template_not_found_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unable_to_access_secret_exception => |e| e.request_id,
                .unable_to_decrypt_secret_value_exception => |e| e.request_id,
                .unable_to_get_upstream_image_exception => |e| e.request_id,
                .unable_to_get_upstream_layer_exception => |e| e.request_id,
                .unable_to_list_upstream_image_referrers_exception => |e| e.request_id,
                .unsupported_image_type_exception => |e| e.request_id,
                .unsupported_upstream_registry_exception => |e| e.request_id,
                .upload_not_found_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

/// The operation did not succeed because the account is managed by a
/// organization policy.
pub const BlockedByOrganizationPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified layer upload does not contain any layer parts.
pub const EmptyUploadException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified pull time update exclusion already exists for the registry.
pub const ExclusionAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified pull time update exclusion was not found.
pub const ExclusionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified image has already been pushed, and there were no changes to
/// the manifest
/// or image tag after the last push.
pub const ImageAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified image is archived and cannot be scanned.
pub const ImageArchivedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified image digest does not match the digest that Amazon ECR
/// calculated for the
/// image.
pub const ImageDigestDoesNotMatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The image requested does not exist in the specified repository.
pub const ImageNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The requested image storage class update is not supported.
pub const ImageStorageClassUpdateNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified image is tagged with a tag that already exists. The repository
/// is
/// configured for tag immutability.
pub const ImageTagAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The layer digest calculation performed by Amazon ECR upon receipt of the
/// image layer does
/// not match the digest specified.
pub const InvalidLayerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The layer part size is not valid, or the first byte specified is not
/// consecutive to
/// the last byte of a previous layer part upload.
pub const InvalidLayerPartException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The last valid byte received from the layer part upload that is associated
    /// with the
    /// exception.
    last_valid_byte_received: ?i64 = null,

    /// The registry ID associated with the exception.
    registry_id: ?[]const u8 = null,

    /// The repository name associated with the exception.
    repository_name: ?[]const u8 = null,

    /// The upload ID associated with the exception.
    upload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_valid_byte_received = "lastValidByteReceived",
        .message = "message",
        .registry_id = "registryId",
        .repository_name = "repositoryName",
        .upload_id = "uploadId",
    };
};

/// The specified parameter is invalid. Review the available parameters for the
/// API
/// request.
pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// An invalid parameter has been specified. Tag keys can have a maximum
/// character length of 128 characters, and tag values can have
/// a maximum length of 256 characters.
pub const InvalidTagParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation failed due to a KMS exception.
pub const KmsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The error code returned by KMS.
    kms_error: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_error = "kmsError",
        .message = "message",
    };
};

/// The image layer already exists in the associated repository.
pub const LayerAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified layer is not available because it is not associated with an
/// image.
/// Unassociated image layers may be cleaned up at any time.
pub const LayerInaccessibleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// Layer parts must be at least 5 MiB in size.
pub const LayerPartTooSmallException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified layers could not be found, or the specified layer is not valid
/// for this
/// repository.
pub const LayersNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The lifecycle policy could not be found, and no policy is set to the
/// repository.
pub const LifecyclePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The previous lifecycle policy preview request has not completed. Wait and
/// try
/// again.
pub const LifecyclePolicyPreviewInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There is no dry run for this repository.
pub const LifecyclePolicyPreviewNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation did not succeed because it would have exceeded a service limit
/// for your
/// account. For more information, see [Amazon ECR service
/// quotas](https://docs.aws.amazon.com/AmazonECR/latest/userguide/service-quotas.html) in
/// the Amazon Elastic Container Registry User Guide.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// A pull through cache rule with these settings already exists for the private
/// registry.
pub const PullThroughCacheRuleAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The pull through cache rule was not found. Specify a valid pull through
/// cache rule and
/// try again.
pub const PullThroughCacheRuleNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The manifest list is referencing an image that does not exist.
pub const ReferencedImagesNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The registry doesn't have an associated registry policy.
pub const RegistryPolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository already exists in the specified registry.
pub const RepositoryAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository contains images. To delete a repository that
/// contains images,
/// you must force the deletion with the `force` parameter.
pub const RepositoryNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository could not be found. Check the spelling of the
/// specified
/// repository and ensure that you are performing operations on the correct
/// registry.
pub const RepositoryNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository and registry combination does not have an
/// associated
/// repository policy.
pub const RepositoryPolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified image scan could not be found. Ensure that image scanning is
/// enabled on
/// the repository and try again.
pub const ScanNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The ARN of the secret specified in the pull through cache rule was not
/// found. Update
/// the pull through cache rule with a valid secret ARN and try again.
pub const SecretNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// These errors are usually caused by a server-side issue.
pub const ServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified signing configuration was not found. This occurs when
/// attempting to retrieve or delete a signing configuration that does not
/// exist.
pub const SigningConfigurationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The repository creation template already exists. Specify a unique prefix and
/// try
/// again.
pub const TemplateAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository creation template can't be found. Verify the
/// registry ID and
/// prefix and try again.
pub const TemplateNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The list of tags on the repository is over the limit. The maximum number of
/// tags that
/// can be applied to a repository is 50.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The secret is unable to be accessed. Verify the resource permissions for the
/// secret
/// and try again.
pub const UnableToAccessSecretException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The secret is accessible but is unable to be decrypted. Verify the resource
/// permisisons and try again.
pub const UnableToDecryptSecretValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The image or images were unable to be pulled using the pull through cache
/// rule. This
/// is usually caused because of an issue with the Secrets Manager secret
/// containing the credentials
/// for the upstream registry.
pub const UnableToGetUpstreamImageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was an issue getting the upstream layer matching the pull through
/// cache
/// rule.
pub const UnableToGetUpstreamLayerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The referrer or referrers were unable to be listed using the pull through
/// cache rule. This
/// is usually caused because of an issue with the Secrets Manager secret
/// containing the credentials
/// for the upstream registry.
pub const UnableToListUpstreamImageReferrersException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The image is of a type that cannot be scanned.
pub const UnsupportedImageTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified upstream registry isn't supported.
pub const UnsupportedUpstreamRegistryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The upload could not be found, or the specified upload ID is not valid for
/// this
/// repository.
pub const UploadNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// There was an exception validating this request.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
