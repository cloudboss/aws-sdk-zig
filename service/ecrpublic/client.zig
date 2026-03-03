const aws = @import("aws");
const std = @import("std");

const batch_check_layer_availability = @import("batch_check_layer_availability.zig");
const batch_delete_image = @import("batch_delete_image.zig");
const complete_layer_upload = @import("complete_layer_upload.zig");
const create_repository = @import("create_repository.zig");
const delete_repository = @import("delete_repository.zig");
const delete_repository_policy = @import("delete_repository_policy.zig");
const describe_image_tags = @import("describe_image_tags.zig");
const describe_images = @import("describe_images.zig");
const describe_registries = @import("describe_registries.zig");
const describe_repositories = @import("describe_repositories.zig");
const get_authorization_token = @import("get_authorization_token.zig");
const get_registry_catalog_data = @import("get_registry_catalog_data.zig");
const get_repository_catalog_data = @import("get_repository_catalog_data.zig");
const get_repository_policy = @import("get_repository_policy.zig");
const initiate_layer_upload = @import("initiate_layer_upload.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_image = @import("put_image.zig");
const put_registry_catalog_data = @import("put_registry_catalog_data.zig");
const put_repository_catalog_data = @import("put_repository_catalog_data.zig");
const set_repository_policy = @import("set_repository_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const upload_layer_part = @import("upload_layer_part.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ECR PUBLIC";

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

    /// Checks the availability of one or more image layers that are within a
    /// repository in a
    /// public registry. When an image is pushed to a repository, each image layer
    /// is checked to
    /// verify if it has been uploaded before. If it has been uploaded, then the
    /// image layer is
    /// skipped.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn batchCheckLayerAvailability(self: *Self, allocator: std.mem.Allocator, input: batch_check_layer_availability.BatchCheckLayerAvailabilityInput, options: batch_check_layer_availability.Options) !batch_check_layer_availability.BatchCheckLayerAvailabilityOutput {
        return batch_check_layer_availability.execute(self, allocator, input, options);
    }

    /// Deletes a list of specified images that are within a repository in a public
    /// registry.
    /// Images are specified with either an `imageTag` or
    /// `imageDigest`.
    ///
    /// You can remove a tag from an image by specifying the image's tag in your
    /// request. When
    /// you remove the last tag from an image, the image is deleted from your
    /// repository.
    ///
    /// You can completely delete an image (and all of its tags) by specifying the
    /// digest of the
    /// image in your request.
    pub fn batchDeleteImage(self: *Self, allocator: std.mem.Allocator, input: batch_delete_image.BatchDeleteImageInput, options: batch_delete_image.Options) !batch_delete_image.BatchDeleteImageOutput {
        return batch_delete_image.execute(self, allocator, input, options);
    }

    /// Informs Amazon ECR that the image layer upload is complete for a specified
    /// public registry,
    /// repository name, and upload ID. You can optionally provide a `sha256` digest
    /// of
    /// the image layer for data validation purposes.
    ///
    /// When an image is pushed, the CompleteLayerUpload API is called once for each
    /// new image
    /// layer to verify that the upload is complete.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn completeLayerUpload(self: *Self, allocator: std.mem.Allocator, input: complete_layer_upload.CompleteLayerUploadInput, options: complete_layer_upload.Options) !complete_layer_upload.CompleteLayerUploadOutput {
        return complete_layer_upload.execute(self, allocator, input, options);
    }

    /// Creates a repository in a public registry. For more information, see [Amazon
    /// ECR
    /// repositories](https://docs.aws.amazon.com/AmazonECR/latest/userguide/Repositories.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn createRepository(self: *Self, allocator: std.mem.Allocator, input: create_repository.CreateRepositoryInput, options: create_repository.Options) !create_repository.CreateRepositoryOutput {
        return create_repository.execute(self, allocator, input, options);
    }

    /// Deletes a repository in a public registry. If the repository contains
    /// images, you must
    /// either manually delete all images in the repository or use the `force`
    /// option.
    /// This option deletes all images on your behalf before deleting the
    /// repository.
    pub fn deleteRepository(self: *Self, allocator: std.mem.Allocator, input: delete_repository.DeleteRepositoryInput, options: delete_repository.Options) !delete_repository.DeleteRepositoryOutput {
        return delete_repository.execute(self, allocator, input, options);
    }

    /// Deletes the repository policy that's associated with the specified
    /// repository.
    pub fn deleteRepositoryPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_repository_policy.DeleteRepositoryPolicyInput, options: delete_repository_policy.Options) !delete_repository_policy.DeleteRepositoryPolicyOutput {
        return delete_repository_policy.execute(self, allocator, input, options);
    }

    /// Returns the image tag details for a repository in a public registry.
    pub fn describeImageTags(self: *Self, allocator: std.mem.Allocator, input: describe_image_tags.DescribeImageTagsInput, options: describe_image_tags.Options) !describe_image_tags.DescribeImageTagsOutput {
        return describe_image_tags.execute(self, allocator, input, options);
    }

    /// Returns metadata that's related to the images in a repository in a public
    /// registry.
    ///
    /// Beginning with Docker version 1.9, the Docker client compresses image layers
    /// before
    /// pushing them to a V2 Docker registry. The output of the `docker images`
    /// command shows the uncompressed image size. Therefore, it might return a
    /// larger image
    /// size than the image sizes that are returned by DescribeImages.
    pub fn describeImages(self: *Self, allocator: std.mem.Allocator, input: describe_images.DescribeImagesInput, options: describe_images.Options) !describe_images.DescribeImagesOutput {
        return describe_images.execute(self, allocator, input, options);
    }

    /// Returns details for a public registry.
    pub fn describeRegistries(self: *Self, allocator: std.mem.Allocator, input: describe_registries.DescribeRegistriesInput, options: describe_registries.Options) !describe_registries.DescribeRegistriesOutput {
        return describe_registries.execute(self, allocator, input, options);
    }

    /// Describes repositories that are in a public registry.
    pub fn describeRepositories(self: *Self, allocator: std.mem.Allocator, input: describe_repositories.DescribeRepositoriesInput, options: describe_repositories.Options) !describe_repositories.DescribeRepositoriesOutput {
        return describe_repositories.execute(self, allocator, input, options);
    }

    /// Retrieves an authorization token. An authorization token represents your IAM
    /// authentication credentials. You can use it to access any Amazon ECR registry
    /// that your IAM
    /// principal has access to. The authorization token is valid for 12 hours. This
    /// API requires
    /// the `ecr-public:GetAuthorizationToken` and
    /// `sts:GetServiceBearerToken` permissions.
    pub fn getAuthorizationToken(self: *Self, allocator: std.mem.Allocator, input: get_authorization_token.GetAuthorizationTokenInput, options: get_authorization_token.Options) !get_authorization_token.GetAuthorizationTokenOutput {
        return get_authorization_token.execute(self, allocator, input, options);
    }

    /// Retrieves catalog metadata for a public registry.
    pub fn getRegistryCatalogData(self: *Self, allocator: std.mem.Allocator, input: get_registry_catalog_data.GetRegistryCatalogDataInput, options: get_registry_catalog_data.Options) !get_registry_catalog_data.GetRegistryCatalogDataOutput {
        return get_registry_catalog_data.execute(self, allocator, input, options);
    }

    /// Retrieve catalog metadata for a repository in a public registry. This
    /// metadata is
    /// displayed publicly in the Amazon ECR Public Gallery.
    pub fn getRepositoryCatalogData(self: *Self, allocator: std.mem.Allocator, input: get_repository_catalog_data.GetRepositoryCatalogDataInput, options: get_repository_catalog_data.Options) !get_repository_catalog_data.GetRepositoryCatalogDataOutput {
        return get_repository_catalog_data.execute(self, allocator, input, options);
    }

    /// Retrieves the repository policy for the specified repository.
    pub fn getRepositoryPolicy(self: *Self, allocator: std.mem.Allocator, input: get_repository_policy.GetRepositoryPolicyInput, options: get_repository_policy.Options) !get_repository_policy.GetRepositoryPolicyOutput {
        return get_repository_policy.execute(self, allocator, input, options);
    }

    /// Notifies Amazon ECR that you intend to upload an image layer.
    ///
    /// When an image is pushed, the InitiateLayerUpload API is called once for each
    /// image layer
    /// that hasn't already been uploaded. Whether an image layer uploads is
    /// determined by the
    /// BatchCheckLayerAvailability API action.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn initiateLayerUpload(self: *Self, allocator: std.mem.Allocator, input: initiate_layer_upload.InitiateLayerUploadInput, options: initiate_layer_upload.Options) !initiate_layer_upload.InitiateLayerUploadOutput {
        return initiate_layer_upload.execute(self, allocator, input, options);
    }

    /// List the tags for an Amazon ECR Public resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates the image manifest and tags that are associated with an
    /// image.
    ///
    /// When an image is pushed and all new image layers have been uploaded, the
    /// PutImage API is
    /// called once to create or update the image manifest and the tags that are
    /// associated with
    /// the image.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn putImage(self: *Self, allocator: std.mem.Allocator, input: put_image.PutImageInput, options: put_image.Options) !put_image.PutImageOutput {
        return put_image.execute(self, allocator, input, options);
    }

    /// Create or update the catalog data for a public registry.
    pub fn putRegistryCatalogData(self: *Self, allocator: std.mem.Allocator, input: put_registry_catalog_data.PutRegistryCatalogDataInput, options: put_registry_catalog_data.Options) !put_registry_catalog_data.PutRegistryCatalogDataOutput {
        return put_registry_catalog_data.execute(self, allocator, input, options);
    }

    /// Creates or updates the catalog data for a repository in a public registry.
    pub fn putRepositoryCatalogData(self: *Self, allocator: std.mem.Allocator, input: put_repository_catalog_data.PutRepositoryCatalogDataInput, options: put_repository_catalog_data.Options) !put_repository_catalog_data.PutRepositoryCatalogDataOutput {
        return put_repository_catalog_data.execute(self, allocator, input, options);
    }

    /// Applies a repository policy to the specified public repository to control
    /// access
    /// permissions. For more information, see [Amazon ECR Repository
    /// Policies](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-policies.html) in the *Amazon Elastic Container Registry User Guide*.
    pub fn setRepositoryPolicy(self: *Self, allocator: std.mem.Allocator, input: set_repository_policy.SetRepositoryPolicyInput, options: set_repository_policy.Options) !set_repository_policy.SetRepositoryPolicyOutput {
        return set_repository_policy.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`.
    /// If existing tags on a resource aren't specified in the request parameters,
    /// they aren't
    /// changed. When a resource is deleted, the tags associated with that resource
    /// are also
    /// deleted.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Uploads an image layer part to Amazon ECR.
    ///
    /// When an image is pushed, each new image layer is uploaded in parts. The
    /// maximum size of
    /// each image layer part can be 20971520 bytes (about 20MB). The
    /// UploadLayerPart API is called
    /// once for each new image layer part.
    ///
    /// This operation is used by the Amazon ECR proxy and is not generally used by
    /// customers for pulling and pushing images. In most cases, you should use the
    /// `docker` CLI to pull, tag, and push images.
    pub fn uploadLayerPart(self: *Self, allocator: std.mem.Allocator, input: upload_layer_part.UploadLayerPartInput, options: upload_layer_part.Options) !upload_layer_part.UploadLayerPartOutput {
        return upload_layer_part.execute(self, allocator, input, options);
    }

    pub fn describeImageTagsPaginator(self: *Self, params: describe_image_tags.DescribeImageTagsInput) paginator.DescribeImageTagsPaginator {
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

    pub fn describeRegistriesPaginator(self: *Self, params: describe_registries.DescribeRegistriesInput) paginator.DescribeRegistriesPaginator {
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
};
