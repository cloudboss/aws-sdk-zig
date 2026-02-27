const SecurityContext = @import("security_context.zig").SecurityContext;
const VolumeMount = @import("volume_mount.zig").VolumeMount;

/// Details of a container.
pub const Container = struct {
    /// The container runtime (such as, Docker or containerd) used to run the
    /// container.
    container_runtime: ?[]const u8,

    /// Container ID.
    id: ?[]const u8,

    /// Container image.
    image: ?[]const u8,

    /// Part of the image name before the last slash. For example, imagePrefix for
    /// public.ecr.aws/amazonlinux/amazonlinux:latest would be
    /// public.ecr.aws/amazonlinux. If the
    /// image name is relative and does not have a slash, this field is empty.
    image_prefix: ?[]const u8,

    /// Container name.
    name: ?[]const u8,

    /// Container security context.
    security_context: ?SecurityContext,

    /// Container volume mounts.
    volume_mounts: ?[]const VolumeMount,

    pub const json_field_names = .{
        .container_runtime = "ContainerRuntime",
        .id = "Id",
        .image = "Image",
        .image_prefix = "ImagePrefix",
        .name = "Name",
        .security_context = "SecurityContext",
        .volume_mounts = "VolumeMounts",
    };
};
