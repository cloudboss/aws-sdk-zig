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

pub const BlockedByOrganizationPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const EmptyUploadException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExclusionAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExclusionNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageArchivedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageDigestDoesNotMatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageStorageClassUpdateNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageTagAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLayerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLayerPartException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTagParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const KmsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LayerAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LayerInaccessibleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LayerPartTooSmallException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LayersNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LifecyclePolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LifecyclePolicyPreviewInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LifecyclePolicyPreviewNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullThroughCacheRuleAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PullThroughCacheRuleNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReferencedImagesNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RegistryPolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryNotEmptyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryPolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ScanNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SecretNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SigningConfigurationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TemplateAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TemplateNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnableToAccessSecretException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnableToDecryptSecretValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnableToGetUpstreamImageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnableToGetUpstreamLayerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedImageTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedUpstreamRegistryException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UploadNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
