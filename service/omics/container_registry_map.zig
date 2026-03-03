const ImageMapping = @import("image_mapping.zig").ImageMapping;
const RegistryMapping = @import("registry_mapping.zig").RegistryMapping;

/// Use a container registry map to specify mappings between the ECR private
/// repository and one or more upstream registries. For more information, see
/// [Container
/// images](https://docs.aws.amazon.com/omics/latest/dev/workflows-ecr.html) in
/// the *Amazon Web Services HealthOmics User Guide*.
pub const ContainerRegistryMap = struct {
    /// Image mappings specify path mappings between the ECR private repository and
    /// their corresponding external repositories.
    image_mappings: ?[]const ImageMapping = null,

    /// Mapping that provides the ECR repository path where upstream container
    /// images are pulled and synchronized.
    registry_mappings: ?[]const RegistryMapping = null,

    pub const json_field_names = .{
        .image_mappings = "imageMappings",
        .registry_mappings = "registryMappings",
    };
};
