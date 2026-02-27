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

pub const EmptyUploadException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ImageAlreadyExistsException = struct {
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

pub const LayerAlreadyExistsException = struct {
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

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReferencedImagesNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RegistryNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RepositoryCatalogDataNotFoundException = struct {
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

pub const ServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedCommandException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UploadNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
