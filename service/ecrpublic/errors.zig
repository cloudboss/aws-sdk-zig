const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        empty_upload_exception: EmptyUploadException,
        image_already_exists_exception: ImageAlreadyExistsException,
        image_digest_does_not_match_exception: ImageDigestDoesNotMatchException,
        image_not_found_exception: ImageNotFoundException,
        image_tag_already_exists_exception: ImageTagAlreadyExistsException,
        invalid_layer_exception: InvalidLayerException,
        invalid_layer_part_exception: InvalidLayerPartException,
        invalid_parameter_exception: InvalidParameterException,
        invalid_tag_parameter_exception: InvalidTagParameterException,
        layer_already_exists_exception: LayerAlreadyExistsException,
        layer_part_too_small_exception: LayerPartTooSmallException,
        layers_not_found_exception: LayersNotFoundException,
        limit_exceeded_exception: LimitExceededException,
        referenced_images_not_found_exception: ReferencedImagesNotFoundException,
        registry_not_found_exception: RegistryNotFoundException,
        repository_already_exists_exception: RepositoryAlreadyExistsException,
        repository_catalog_data_not_found_exception: RepositoryCatalogDataNotFoundException,
        repository_not_empty_exception: RepositoryNotEmptyException,
        repository_not_found_exception: RepositoryNotFoundException,
        repository_policy_not_found_exception: RepositoryPolicyNotFoundException,
        server_exception: ServerException,
        too_many_tags_exception: TooManyTagsException,
        unsupported_command_exception: UnsupportedCommandException,
        upload_not_found_exception: UploadNotFoundException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .empty_upload_exception => "EmptyUploadException",
                .image_already_exists_exception => "ImageAlreadyExistsException",
                .image_digest_does_not_match_exception => "ImageDigestDoesNotMatchException",
                .image_not_found_exception => "ImageNotFoundException",
                .image_tag_already_exists_exception => "ImageTagAlreadyExistsException",
                .invalid_layer_exception => "InvalidLayerException",
                .invalid_layer_part_exception => "InvalidLayerPartException",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_tag_parameter_exception => "InvalidTagParameterException",
                .layer_already_exists_exception => "LayerAlreadyExistsException",
                .layer_part_too_small_exception => "LayerPartTooSmallException",
                .layers_not_found_exception => "LayersNotFoundException",
                .limit_exceeded_exception => "LimitExceededException",
                .referenced_images_not_found_exception => "ReferencedImagesNotFoundException",
                .registry_not_found_exception => "RegistryNotFoundException",
                .repository_already_exists_exception => "RepositoryAlreadyExistsException",
                .repository_catalog_data_not_found_exception => "RepositoryCatalogDataNotFoundException",
                .repository_not_empty_exception => "RepositoryNotEmptyException",
                .repository_not_found_exception => "RepositoryNotFoundException",
                .repository_policy_not_found_exception => "RepositoryPolicyNotFoundException",
                .server_exception => "ServerException",
                .too_many_tags_exception => "TooManyTagsException",
                .unsupported_command_exception => "UnsupportedCommandException",
                .upload_not_found_exception => "UploadNotFoundException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .empty_upload_exception => |e| e.message,
                .image_already_exists_exception => |e| e.message,
                .image_digest_does_not_match_exception => |e| e.message,
                .image_not_found_exception => |e| e.message,
                .image_tag_already_exists_exception => |e| e.message,
                .invalid_layer_exception => |e| e.message,
                .invalid_layer_part_exception => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_tag_parameter_exception => |e| e.message,
                .layer_already_exists_exception => |e| e.message,
                .layer_part_too_small_exception => |e| e.message,
                .layers_not_found_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .referenced_images_not_found_exception => |e| e.message,
                .registry_not_found_exception => |e| e.message,
                .repository_already_exists_exception => |e| e.message,
                .repository_catalog_data_not_found_exception => |e| e.message,
                .repository_not_empty_exception => |e| e.message,
                .repository_not_found_exception => |e| e.message,
                .repository_policy_not_found_exception => |e| e.message,
                .server_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unsupported_command_exception => |e| e.message,
                .upload_not_found_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .empty_upload_exception => 400,
                .image_already_exists_exception => 400,
                .image_digest_does_not_match_exception => 400,
                .image_not_found_exception => 400,
                .image_tag_already_exists_exception => 400,
                .invalid_layer_exception => 400,
                .invalid_layer_part_exception => 400,
                .invalid_parameter_exception => 400,
                .invalid_tag_parameter_exception => 400,
                .layer_already_exists_exception => 400,
                .layer_part_too_small_exception => 400,
                .layers_not_found_exception => 400,
                .limit_exceeded_exception => 400,
                .referenced_images_not_found_exception => 400,
                .registry_not_found_exception => 400,
                .repository_already_exists_exception => 400,
                .repository_catalog_data_not_found_exception => 400,
                .repository_not_empty_exception => 400,
                .repository_not_found_exception => 400,
                .repository_policy_not_found_exception => 400,
                .server_exception => 500,
                .too_many_tags_exception => 400,
                .unsupported_command_exception => 400,
                .upload_not_found_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .empty_upload_exception => |e| e.request_id,
                .image_already_exists_exception => |e| e.request_id,
                .image_digest_does_not_match_exception => |e| e.request_id,
                .image_not_found_exception => |e| e.request_id,
                .image_tag_already_exists_exception => |e| e.request_id,
                .invalid_layer_exception => |e| e.request_id,
                .invalid_layer_part_exception => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_tag_parameter_exception => |e| e.request_id,
                .layer_already_exists_exception => |e| e.request_id,
                .layer_part_too_small_exception => |e| e.request_id,
                .layers_not_found_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .referenced_images_not_found_exception => |e| e.request_id,
                .registry_not_found_exception => |e| e.request_id,
                .repository_already_exists_exception => |e| e.request_id,
                .repository_catalog_data_not_found_exception => |e| e.request_id,
                .repository_not_empty_exception => |e| e.request_id,
                .repository_not_found_exception => |e| e.request_id,
                .repository_policy_not_found_exception => |e| e.request_id,
                .server_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unsupported_command_exception => |e| e.request_id,
                .upload_not_found_exception => |e| e.request_id,
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

/// The specified layer upload doesn't contain any layer parts.
pub const EmptyUploadException = struct {
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

/// The specified image digest doesn't match the digest that Amazon ECR
/// calculated for the
/// image.
pub const ImageDigestDoesNotMatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The image requested doesn't exist in the specified repository.
pub const ImageNotFoundException = struct {
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

/// The layer digest calculation performed by Amazon ECR when the image layer
/// doesn't match the
/// digest specified.
pub const InvalidLayerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The layer part size isn't valid, or the first byte specified isn't
/// consecutive to the
/// last byte of a previous layer part upload.
pub const InvalidLayerPartException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The position of the last byte of the layer part.
    last_valid_byte_received: ?i64 = null,

    /// The Amazon Web Services account ID that's associated with the layer part.
    registry_id: ?[]const u8 = null,

    /// The name of the repository.
    repository_name: ?[]const u8 = null,

    /// The upload ID that's associated with the layer part.
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
/// character length of 128 characters, and tag values can have a maximum length
/// of 256 characters.
pub const InvalidTagParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
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

/// Layer parts must be at least 5 MiB in size.
pub const LayerPartTooSmallException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified layers can't be found, or the specified layer isn't valid for
/// this
/// repository.
pub const LayersNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The operation didn't succeed because it would have exceeded a service limit
/// for your
/// account. For more information, see [Amazon ECR Service
/// Quotas](https://docs.aws.amazon.com/AmazonECR/latest/userguide/service-quotas.html) in the
/// Amazon Elastic Container Registry User Guide.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The manifest list is referencing an image that doesn't exist.
pub const ReferencedImagesNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The registry doesn't exist.
pub const RegistryNotFoundException = struct {
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

/// The repository catalog data doesn't exist.
pub const RepositoryCatalogDataNotFoundException = struct {
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

/// The specified repository can't be found. Check the spelling of the specified
/// repository
/// and ensure that you're performing operations on the correct registry.
pub const RepositoryNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The specified repository and registry combination doesn't have an associated
/// repository
/// policy.
pub const RepositoryPolicyNotFoundException = struct {
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

/// The action isn't supported in this Region.
pub const UnsupportedCommandException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The upload can't be found, or the specified upload ID isn't valid for this
/// repository.
pub const UploadNotFoundException = struct {
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
